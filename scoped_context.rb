require 'json'
require './reformat_examples'

DM_BASE_IRI = "http://datamodel.clinicalgenome.org/types/"

def construct_scoped_context(data_dir = File.join('data', 'flattened'))
  dmwg_examples = DMWGExampleData.new('data/flattened')
  types = dmwg_examples.types
  identifier_systems = dmwg_examples.by_type['IdentifierSystem']

  cx = {
          cg: DM_BASE_IRI,
          base: DM_BASE_IRI,
          id: "@id",
          type: "@type"
        }

  identifier_systems.each do |is|
    cx[is['prefix']] = is['iri']
  end

  types.each do |id, type|
    subcontext = {}
    attributes = type['attributes'].sort_by { |x| x['precedence'].to_f || 0}
    attributes.each do |attrib|
      if ['string', 'int', 'boolean', 'float'].include? attrib['dataType']
        subcontext[attrib['name']] = "cg:#{attrib['name']}"
      else
        subcontext[attrib['name']] = { "@id" => "cg:#{attrib['name']}", "@type" => "@id" }
      end
    end
    cx[type['name']] = {
      "@id" => type['externalIRI'] || ("cg:" + type['name']),
      "@context" => subcontext
    }
  end

  return { "@context" => cx }
end

if __FILE__ == $0
  print JSON.pretty_generate(construct_scoped_context())
end
