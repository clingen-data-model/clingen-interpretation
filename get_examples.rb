require 'rubyXL'
require 'net/http'
require 'uri'
require 'json'

EXAMPLES_URL = "https://docs.google.com/spreadsheets/d/1fL3naWSpL_iDxkCN51g1CSLhXU6uAd1vwxZ0m1I4Zeg/pub?output=xlsx"


if ARGV[0] then
	wb = RubyXL::Parser.parse(ARGV[0])
else
	STDERR.puts "Downloading from #{EXAMPLES_URL}"
	STDERR.puts "For repetitive testing, you can download this manually and add the file as an argument to this script"
	wb = RubyXL::Parser.parse_buffer(Net::HTTP.get(URI.parse(EXAMPLES_URL)))
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
	raw_examples[ws.sheet_name] = sheet_data
end

puts JSON.pretty_generate(raw_examples)
