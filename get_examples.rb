require 'rubyXL'
require 'net/http'
require 'uri'
require 'json'
require 'fileutils'

FLAT_DATA_DIR = "data/flattened"
DOCS_DIR = "docs"
ACMG_EXAMPLE_DATA_SHEET = "ACMG Rule Examples Data.xlsx"
ACMG_CRITERION_ASSESS_EXAMPLES = "Criterion Assessment Examples.docx"
ACMG_EXAMPLE_DATA_URL = "https://docs.google.com/spreadsheets/d/1yI60xriX7J4vk9h4eNK49YKfNnKuKDK6QkHe3OkV9oA/pub?output=xlsx"
ACMG_CRITERION_ASSESS_EXAMPLES_URL = "https://docs.google.com/document/d/1C7XDX0T5oB2TO3R4vy1wFuJCq0v-R66YKjZi3hiNbQU/export?format=doc"

# command line options...
# if an argument is passed then it will not Download the examples google sheet and crit assessment doc.
#   the argument will be presumed to be a reference to a valid XML file that will be parsed in a excel workbook form
#   the benefit of this is to use it as a shortcut to avoid re-downloading the google sheet and simply reprocess the
#   the current sheet alread available in XML file format.
# if no argument is passed then both the DMWG example google sheet and docs will be downloaded and processed (flattened)
if ARGV[0] then
	STDERR.puts "Reading from #{ARGV[0]}"
	STDERR.puts "For a snapshot of the latest data, omit the static filename and it will download from the source GoogleSheet."
	wb = RubyXL::Parser.parse(ARGV[0])
else
	STDERR.puts "Downloading from #{ACMG_EXAMPLE_DATA_URL} and writing to folder #{DOCS_DIR}"
	STDERR.puts "For repetitive testing, you can download this manually and add the file as an argument to this script"
	FileUtils.makedirs(DOCS_DIR)
	FileUtils.makedirs(FLAT_DATA_DIR)
	wb = RubyXL::Parser.parse_buffer(Net::HTTP.get(URI.parse(ACMG_EXAMPLE_DATA_URL)))
	wb.write(DOCS_DIR+"/"+ACMG_EXAMPLE_DATA_SHEET)

	doc = Net::HTTP.get(URI.parse(ACMG_CRITERION_ASSESS_EXAMPLES_URL))
	f = File.open(DOCS_DIR+"/"+ACMG_CRITERION_ASSESS_EXAMPLES, "w")
	f.write(doc)
	f.close
end

# temp raw examples object to gather and display results.
raw_examples = {}

# loops through worksheets in downloaded DMWG example worksheet
wb.worksheets.each do |ws|

	# ignore the temporary SEPIO sheets
	next if ws.sheet_name.start_with? 'SEPIO' 

	headers = []
	sheet_data = []

	# loop through the rows of each sheet
	ws.each_with_index do |row, index|
		# capture the header cells into a map
		if index == 0 then
			headers = row.cells.map { |c| c && c.value }
			# skip to next row
			next
		end
		# for all rows except header row, start here (skip if row is blank or first cell is blank or first cell value is blank)
		next if row.nil? || row.cells[0].nil? || row.cells[0].value.nil?
		# convert the row data to a hash by first filtering out the columns that have invalid headers (blank, empty, start with underscore)
		row_data = Hash[headers.zip(row.cells.map { |c| c && c.value })]
			.delete_if { |k, v| k.nil? || k.empty? || k.start_with?("_") || v.nil? }
		# append processed row data to sheet data array as long as row_data has at least one valid cell in it.
		sheet_data << row_data if row_data.length > 0
	end

  # "join" tables start with '_', all others should be listed by primary key
	if !ws.sheet_name.start_with? '_' then
		sheet_data = sheet_data.reduce({}) { |acc, r| acc.merge({r['id'] => r})}
	end

	# gather sheet data for the purpose of displaying to console afterwards
	raw_examples[ws.sheet_name] = sheet_data
	
	# create a file (in write mode) based on the sheet name
	json_file = File.open(FLAT_DATA_DIR+"/"+ws.sheet_name+".json", "w")
	# write the contents of the sheet data to the file
	json_file.write(JSON.pretty_generate(sheet_data))
	# close the file
	json_file.close

end

# display the full contents of the processed sheet data
puts JSON.pretty_generate(raw_examples)
