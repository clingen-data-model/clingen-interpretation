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

attributes_by_entity = Hash.new { |hash, key| hash[key] = [] }
attributes.each do |a_id, a_rec|
  attributes_by_entity[a_rec['entityId']].push(a_rec)
end
attributes_by_entity.each do |e_id, a_recs|
  a_recs.sort_by! { |x| x['precedence'].to_f || 0}
end

types.each do |id, type|
  subcontext = {}
  attributes_by_entity[id].each do |attrib|
    if ['String', 'int', 'boolean', 'float'].include? attrib['dataType']
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

print JSON.pretty_generate({ "@context" => cx })
