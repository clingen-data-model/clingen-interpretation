require 'json'

DM_BASE_IRI = "http://datamodel.clinicalgenome.org/types/"
AR_BASE_IRI = "http://schema.genome.network/"

types = JSON.parse(File.read('data/flattened/Type.json'))
attributes = JSON.parse(File.read('data/flattened/Attribute.json'))

cx = {
        cg: DM_BASE_IRI,
        base: DM_BASE_IRI,
        gns: AR_BASE_IRI,
        id: "@id",
        type: "@type"
      }

attributes.each do |id, attrib|
  if ['String', 'int', 'boolean', 'float'].include? attrib['dataType']
    cx[attrib['name']] = "cg:#{attrib['name']}"
  else
    cx[attrib['name']] = { "@id" => "cg:#{attrib['name']}", "@type" => "@id" }
  end
end

print JSON.pretty_generate({ "@context" => cx })
