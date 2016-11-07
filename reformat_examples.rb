#!/usr/bin/ruby

require 'json'
require 'yaml'

$dmwgExamples = Hash.new { |hash, key| hash[key] = {} }

$flattened = Hash[Dir["data/flattened/*.json"].collect { |jsonfile|
	[File.basename(jsonfile, '.json'), JSON.parse(File.read(jsonfile))]
}]

#puts $flattened.to_yaml

$entity_attributes = Hash.new { |hash, key| hash[key] = [] }
$flattened['Attribute'].each do |a_id, a_rec|
	$entity_attributes[a_rec['entityId']].push(a_rec)
end

$entity_attributes.each do |e_id, a_recs|
	a_recs.sort_by! { |x| x['precedence'] || 0}
end

def convert_value(value, type)
	case type
	when 'String'
		value
	when 'int'
		value.to_i
	when 'float'
		value.to_f
	when 'boolean'
		!!value
	when '???' # These should be fixed in the upstream data
		value
	when 'CodeableConcept'
		# FIXME
		value
	else
		$dmwgExamples[value]
	end
end

def apply_attributes(entity_id, in_record, out_record)
	$entity_attributes[entity_id].each do |attribute|
		if in_record.key? attribute['name'] then
			out_record[attribute['name']] = convert_value(in_record[attribute['name']], attribute['dataType'])
		end
	end
end

$flattened['Entity'].each do |e_id, e_rec|
	e_name = e_rec['name']
	STDERR.puts "#{e_id}, #{e_name}"
	if e_name === 'Entity' then next end
	## FIXME Data sheet represents many different entities
	## consider moving Data.explanation to DataAttribute table
	if e_name === 'Data' then next end
	if $flattened.key? e_name then
		# full fledged table for this entity (not a Data subtype)
		STDERR.puts "### has a full table!"
		$flattened[e_name].each do |id, rec|
			ex = $dmwgExamples[id]
			ex['@id'] = id
			apply_attributes(e_id, rec, ex)
			# handle inherited attributes
			parent = e_rec['parentEntityTypeId']
			while !!parent
				apply_attributes(parent, rec, ex)
				parent = $flattened['Entity'][parent]['parentEntityTypeId']
			end
		end
	else
		# try the Data and DataAttribute tables
		STDERR.puts "### no table for this one!"
	end
end

$flattened['DataAttribute'].each do |k, v|
	# FIXME - make sure inherited attributes are appropriately handled
	attribute = $flattened['Attribute'][v['attributeId']]
	$dmwgExamples[v['evidenceDataId']]['@id'] = v['evidenceDataId']
	$dmwgExamples[v['evidenceDataId']][attribute['name']] = convert_value(v['value'], attribute['dataType'])
end

# TODO: joins using ActivityAgentAssociation, ActivityUsedEntity
# consider merging this code with DataAttribute handling

$flattened['ActivityAgentAssociation'].each do |aaa|
	activity = $dmwgExamples[aaa['activityId']]
	(activity['wasAssociatedWith'] ||= []).push({ 'agent' => aaa['wasAssociatedWith'], 'role' => $flattened['Attribute'][aaa['roleAttributeId']]['name']})
end

$flattened['ActivityUsedEntity'].each do |aue|
	activity = $dmwgExamples[aue['activityId']]
	((activity['used'] ||= {})[$flattened['Entity'][aue['usedEntityType']]['name']] ||= []).push($dmwgExamples[aue['usedEntityId']])
end

puts $dmwgExamples['VarInterp001'].to_yaml
