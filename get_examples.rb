require 'rubyXL'
require 'net/http'
require 'uri'
require 'json'
require 'fileutils'


FLAT_DATA_DIR = "data/flattened"
DOCS_DIR = "docs"
ACMG_EXAMPLE_DATA_SHEET = "ACMG Rule Examples Data.xlsx"
ACMG_CRITERION_ASSESS_EXAMPLES = "Criterion Assessment Examples.docx"
ACMG_EXAMPLE_DATA_URL = "https://docs.google.com/spreadsheets/d/1fL3naWSpL_iDxkCN51g1CSLhXU6uAd1vwxZ0m1I4Zeg/pub?output=xlsx"
ACMG_CRITERION_ASSESS_EXAMPLES_URL = "https://docs.google.com/document/d/1C7XDX0T5oB2TO3R4vy1wFuJCq0v-R66YKjZi3hiNbQU/export?format=doc"

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

raw_examples = {}

wb.worksheets.each do |ws|
	headers = []
	sheet_data = []
	ws.each_with_index do |row, index|
		if index == 0 then
			headers = row.cells.map { |c| c && c.value }
			next
		end
		next if row.nil? || row.cells[0].nil? || row.cells[0].value.nil?
		row_data = Hash[headers.zip(row.cells.map { |c| c && c.value })]
			.delete_if { |k, v| k.nil? || k.empty? || v.nil? }
		sheet_data << row_data if row_data.length > 1
	end
  # "join" tables start with '_', all others should be listed by primary key
	if !ws.sheet_name.start_with? '_' then
		sheet_data = sheet_data.reduce({}) { |acc, r| acc.merge({r['id'] => r})}
	end
	raw_examples[ws.sheet_name] = sheet_data
	json_file = File.open(FLAT_DATA_DIR+"/"+ws.sheet_name+".json", "w")
	json_file.write(JSON.pretty_generate(sheet_data))
	json_file.close

end

puts JSON.pretty_generate(raw_examples)
