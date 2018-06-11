require 'json'
require './reformat_examples'

DM_BASE_IRI = "http://datamodel.clinicalgenome.org/"
DM_TYPES_IRI = "http://datamodel.clinicalgenome.org/types/"
DM_ATTRS_IRI = "http://datamodel.clinicalgenome.org/attributes/"

def construct_context(data_dir = File.join('data', 'flattened'))
  dmwg_examples = DMWGExampleData.new('data/flattened')
  types = dmwg_examples.types_by_entity_id
  identifier_systems = dmwg_examples.data_by_entity_type['IdentifierSystem']

  cx = {
          "cg-types" => DM_TYPES_IRI,
          "cg-attributes" => DM_ATTRS_IRI,
          "base" => DM_BASE_IRI,
          "id" => "@id",
          "type" => "@type"
        }

  identifier_systems.each do |is|
    cx[is['prefix']] = is['urlPattern']
  end

  types.each do |id, type|
    ldid = type['iri'] && !type['iri'].include?('?') && type['iri'].split("\n").length == 1 ? type['iri'] : "cg-types:#{type['name']}"
    cx[type['name']] = { "@id" => ldid }
    type['attributes'].each do |attrib|
      ldid = attrib['iri'] && !attrib['iri'].include?('?') && attrib['iri'].split("\n").length == 1 ? attrib['iri'] : "cg-attributes:#{attrib['name']}"
      if ['string', 'int', 'boolean', 'float'].include? attrib['dataType']
        cx[attrib['name']] = ldid
      else
        cx[attrib['name']] = { "@id" => ldid, "@type" => "@id" }
      end
    end
  end

  return { "@context" => cx }
end

if __FILE__ == $0
  print JSON.pretty_generate(construct_context())
end
