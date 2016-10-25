require 'rubyXL'
require 'net/http'
require 'uri'
require 'json'


GOOGLE_DATA_FOLDER = "data/google"
ACMG_EXAMPLE_DATA_SHEET = "ACMG Rule Examples Data.xlsx"
ACMG_CRITERION_ASSESS_EXAMPLES = "Criterion Assessment Examples.docx"
ACMG_EXAMPLE_DATA_URL = "https://docs.google.com/spreadsheets/d/1fL3naWSpL_iDxkCN51g1CSLhXU6uAd1vwxZ0m1I4Zeg/pub?output=xlsx"
ACMG_CRITERION_ASSESS_EXAMPLES_URL = "https://docs.google.com/document/d/1C7XDX0T5oB2TO3R4vy1wFuJCq0v-R66YKjZi3hiNbQU/export?format=doc"

if ARGV[0] then
	STDERR.puts "Reading from #{ARGV[0]}"
	STDERR.puts "For a snapshot of the latest data, omit the static filename and it will download from the source GoogleSheet."
	wb = RubyXL::Parser.parse(ARGV[0])
else
	STDERR.puts "Downloading from #{ACMG_EXAMPLE_DATA_URL} and writing to folder #{GOOGLE_DATA_FOLDER}"
	STDERR.puts "For repetitive testing, you can download this manually and add the file as an argument to this script"
	wb = RubyXL::Parser.parse_buffer(Net::HTTP.get(URI.parse(ACMG_EXAMPLE_DATA_URL)))
	wb.write(GOOGLE_DATA_FOLDER+"/"+ACMG_EXAMPLE_DATA_SHEET)

	doc = Net::HTTP.get(URI.parse(ACMG_CRITERION_ASSESS_EXAMPLES_URL))
	f = File.open(GOOGLE_DATA_FOLDER+"/"+ACMG_CRITERION_ASSESS_EXAMPLES, "w")
	f.write(doc)
	f.close
end

raw_examples = {}

wb.worksheets.each do |ws|
	headers = []
	sheet_data = []
	header_index = (ws.sheet_name.start_with? 'VS-') ? 1 : 0
	ws.each_with_index do |row, index|
		next if index < header_index
		if index == header_index then
			headers = row.cells.map { |c| c && c.value }
			next
		end
		next if row.nil? || row.cells[0].nil? || row.cells[0].value.nil?
		row_data = Hash[headers.zip(row.cells.map { |c| c && c.value })]
			.delete_if { |k, v| k.nil? || k.empty? || v.nil? }
		sheet_data << row_data
	end
        sheet_hash = sheet_data.reduce({}) { |acc, r| acc.merge({r['id'] => r})}
	raw_examples[ws.sheet_name] = sheet_hash
	json_file = File.open(GOOGLE_DATA_FOLDER+"/"+ws.sheet_name+".json", "w")
	json_file.write(JSON.pretty_generate(sheet_hash))
	json_file.close

end

puts JSON.pretty_generate(raw_examples)
