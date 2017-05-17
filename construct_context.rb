require 'json'
require 'net/http'
require 'csv'
require 'fileutils'
require 'pathname'
require 'yaml'

DM_BASE_IRI = "http://datamodel.clinicalgenome.org/types/"
AR_BASE_IRI = "http://schema.genome.network/"

CSV_DATA = {classes: {url: "https://docs.google.com/spreadsheets/d/1yI60xriX7J4vk9h4eNK49YKfNnKuKDK6QkHe3OkV9oA/pub?gid=1184726012&single=true&output=csv",
                      path: "docs/dmclasses.csv"},
             properties: {url: "https://docs.google.com/spreadsheets/d/1yI60xriX7J4vk9h4eNK49YKfNnKuKDK6QkHe3OkV9oA/pub?gid=1228172421&single=true&output=csv",
                          path: "docs/dmproperties.csv"}}

cx = {
        cg: DM_BASE_IRI,
        gns: AR_BASE_IRI
      }
                          
# Grab CSV from URL if necessary, otherwise read from existing file
def fetch_csv(spec, use_existing = true)
  csv_data = nil
  if use_existing && Pathname.new(spec[:path]).exist?
    csv_data = File.open(spec[:path]) { |f| csv_data = f.read }
  else
    csv_data = Net::HTTP.get(URI.parse(spec[:url]))
    File.open(spec[:path], 'wb') { |f| f << csv_data }
  end
  CSV.parse(csv_data)
end

# Add classes in spec ({iri: x, path: y}) to cx
def add_to_context(cx, spec)
  classes = fetch_csv(spec)
  class_headers = classes.shift
  class_id_idx = class_headers.find_index { |i| i == "id" }
  class_name_idx = class_headers.find_index { |i| i == "name" }
  classes.reduce(cx) do |acc, i|
    if i[class_id_idx] && i[class_id_idx].strip.length > 0
      acc.merge!({"cg:#{i[class_id_idx].strip}" => i[class_name_idx].strip})
    else
      cx
    end
  end
end

cx = add_to_context(cx, CSV_DATA[:classes])
cx = add_to_context(cx, CSV_DATA[:properties])
cx = {"@context" => cx}
File.open("data/context.jsonld", 'wb') { |f| f << JSON.pretty_generate(cx) }
