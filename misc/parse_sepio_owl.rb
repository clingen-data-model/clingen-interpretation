require 'rdf'
require 'rdf/rdfxml'
require 'json'

OBO_PREFIX = "http://purl.obolibrary.org/obo/"
SEPIO_PREFIX = OBO_PREFIX + "SEPIO_"
IAO_PREFIX = OBO_PREFIX + "IAO_"

OWL_FILES_PREFIX = "https://raw.githubusercontent.com/monarch-initiative/SEPIO-ontology/master/src/ontology/"

sepio = RDF::Graph.load(OWL_FILES_PREFIX + "sepio.owl")
sepio.load(OWL_FILES_PREFIX + "extensions/clingen/sepio-clingen.owl")

terms2labels = Hash[[
#  ["0000111", "editor_preferred_term"],
#  ["0000112", "example_of_usage"],
#  ["0000114", "has_curation_status"],
  ["0000115", "definition"],
#  ["0000116", "editor_note"],
#  ["0000117", "term_editor"],
#  ["0000118", "alternative_term"],
#  ["0000119", "definition_source"],
#  ["0000232", "curator_note"],
  ["0000412", "imported_from"]
].map { |k,v| [RDF::URI(IAO_PREFIX + k), v]}]

terms2labels[RDF::RDFS.label] = 'label'
terms2labels[RDF::RDFS.comment] = 'comment'

# create a hash of SEPIO ids to all of the quads involving that id
# sepio_term_quads = Hash.new { |h,k| h[k] = [] }.tap do |h|
#   sepio.quads
#     .select { |quad| quad[0].iri? and quad[0].start_with? SEPIO_PREFIX }
#     .each { |quad| h[quad[0].to_s[(SEPIO_PREFIX.length)..-1]] << quad }
# end

SEPIO_PREFIX_LENGTH = SEPIO_PREFIX.length
sepio_annotations = Hash.new { |h,k| h[k] = Hash.new { |i, l| i[l] = [] } }.tap do |h|
  sepio.triples
    .select { |t| t[0].iri? and t[0].start_with? SEPIO_PREFIX and terms2labels.has_key? t[1] }
    .each { |t| h[t[0].to_s[SEPIO_PREFIX_LENGTH..-1]][terms2labels[t[1]]] << t[2].to_s }
end

puts JSON.pretty_generate(sepio_annotations)

# more of a LD-approach below...
# context = JSON.parse %({
#   "@context": {
#     "dc": "http://purl.org/dc/elements/1.1/",
#     "dcterms": "http://purl.org/dc/terms/",
#     "eco": "http://purl.obolibrary.org/obo/eco/",
#     "foaf": "http://xmlns.com/foaf/0.1/",
#     "obo": "http://purl.obolibrary.org/obo/",
#     "oboInOwl": "http://www.geneontology.org/formats/oboInOwl#",
#     "owl": "http://www.w3.org/2002/07/owl#",
#     "protege": "http://protege.stanford.edu/plugins/owl/protege#",
#     "rdf": "http://www.w3.org/1999/02/22-rdf-syntax-ns#",
#     "rdfs": "http://www.w3.org/2000/01/rdf-schema#",
#     "skos": "http://www.w3.org/2004/02/skos/core#",
#     "xsd": "http://www.w3.org/2001/XMLSchema#"
#   }
# })
#
# sepio_terms = JSON::LD::API::fromRdf(sepio).select { |x| x['@id'].start_with? "http://purl.obolibrary.org/obo/SEPIO_" }
