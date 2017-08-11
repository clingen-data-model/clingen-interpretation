require 'json'

DM_BASE_IRI = "http://datamodel.clinicalgenome.org/"
DM_TYPES_IRI = "http://datamodel.clinicalgenome.org/types/"
DM_ATTRS_IRI = "http://datamodel.clinicalgenome.org/attributes/"
AR_BASE_IRI = "http://schema.genome.network/"

def construct_context(data_dir = File.join('data', 'flattened'))
  types = JSON.parse(File.read(File.join(data_dir, "Type.json")))
  attributes = JSON.parse(File.read(File.join(data_dir, "Attribute.json")))

  cx = {
          "cg-types": DM_TYPES_IRI,
          "cg-attributes": DM_ATTRS_IRI,
          base: DM_BASE_IRI,
          gns: AR_BASE_IRI,
          id: "@id",
          type: "@type"
        }

  types.each do |id, type|
    cx[type['name']] = { "@id" => "cg-types:#{type['name']}" }
  end

  attributes.each do |id, attrib|
    if ['String', 'int', 'boolean', 'float'].include? attrib['dataType']
      cx[attrib['name']] = "cg-attributes:#{attrib['name']}"
    else
      cx[attrib['name']] = { "@id" => "cg-attributes:#{attrib['name']}", "@type" => "@id" }
    end
  end

  return { "@context" => cx }
end

if __FILE__ == $0
  print JSON.pretty_generate(construct_context())
end
