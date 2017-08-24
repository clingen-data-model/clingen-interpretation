require 'json'

SCOPED_DM_BASE_IRI = "http://datamodel.clinicalgenome.org/"
SCOPED_AR_BASE_IRI = "http://schema.genome.network/"

def ldid_for_item(x)
  # get linked_data id for an item, using iri if available and unambiguous
  iri = x['iri']
  return iri && !iri.include?("?") && iri.split("\n").length == 1 ? iri : "cg:#{x['name']}"
end

def construct_scoped_context(data_dir = File.join('data', 'flattened'))
  types = JSON.parse(File.read(File.join(data_dir, "Type.json")))
  attributes = JSON.parse(File.read(File.join(data_dir, "Attribute.json")))

  cx = {
          "cg" => SCOPED_DM_BASE_IRI,
          "base" => SCOPED_DM_BASE_IRI,
          "gns" => SCOPED_AR_BASE_IRI,
          "id" => "@id",
          "type" => "@type"
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
      attr_ldid = ldid_for_item(attrib)
      if ['String', 'int', 'boolean', 'float'].include? attrib['dataType']
        subcontext[attrib['name']] = attr_ldid
      else
        subcontext[attrib['name']] = { "@id" => attr_ldid, "@type" => "@id" }
      end
    end
    type_ldid = ldid_for_item(type)
    cx[type['name']] = {
      "@id" => type_ldid,
      "@context" => subcontext
    }
  end
  
  return { "@context" => cx }
end

if __FILE__ == $0
  print JSON.pretty_generate(construct_scoped_context())
end
