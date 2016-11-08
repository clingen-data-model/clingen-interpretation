#!/usr/bin/ruby

require 'json'
require 'yaml'

class DMWGExampleData

  def initialize(data_dir)
    # an "auto hash" to hold all of the examples
    @id2example = Hash.new { |hash, key| hash[key] = {} }

    # slurp in all the json files in the `data_dir`
    @flattened = Hash[Dir["#{data_dir}/*.json"].collect { |jsonfile|
      [File.basename(jsonfile, '.json'), JSON.parse(File.read(jsonfile))]
    }]

    # Read in the Attribute sheet
    @entity2attributes = Hash.new { |hash, key| hash[key] = [] }
    @flattened['Attribute'].each do |a_id, a_rec|
      @entity2attributes[a_rec['entityId']].push(a_rec)
    end
    @entity2attributes.each do |e_id, a_recs|
      a_recs.sort_by! { |x| x['precedence'] || 0}
    end

    # Process the `Entity` sheet
    @flattened['Entity'].each do |e_id, e_rec|
      e_name = e_rec['name']
      if e_name === 'Entity' then next end
      ## FIXME Data sheet represents many different entities
      ## consider moving Data.explanation to DataAttribute table
      if e_name === 'Data' then next end
      if @flattened.key? e_name then
      # full fledged table for this entity (not a Data subtype)
      @flattened[e_name].each do |id, rec|
        ex = @id2example[id]
        ex['@id'] = id
        apply_attributes(e_id, rec, ex)
        # handle inherited attributes
        parent = e_rec['parentEntityTypeId']
        while !!parent
        apply_attributes(parent, rec, ex)
        parent = @flattened['Entity'][parent]['parentEntityTypeId']
        end
      end
      end
    end

    # Now for the "join tables"
    @flattened['DataAttribute'].each do |k, v|
      # FIXME - make sure inherited attributes are appropriately handled
      attribute = @flattened['Attribute'][v['attributeId']]
      @id2example[v['evidenceDataId']]['@id'] = v['evidenceDataId']
      @id2example[v['evidenceDataId']][attribute['name']] = convert_value(v['value'], attribute['dataType'])
    end

    @flattened['ActivityAgentAssociation'].each do |aaa|
      activity = @id2example[aaa['activityId']]
      (activity['wasAssociatedWith'] ||= []).push({ 'agent' => aaa['wasAssociatedWith'], 'role' => @flattened['Attribute'][aaa['roleAttributeId']]['name']})
    end

    @flattened['ActivityUsedEntity'].each do |aue|
      activity = @id2example[aue['activityId']]
      ((activity['used'] ||= {})[@flattened['Entity'][aue['usedEntityType']]['name']] ||= []).push(@id2example[aue['usedEntityId']])
    end
  end

  def by_id
    return @id2example
  end

  private

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
    @id2example[value]
    end
  end

  # loops through attributes defined for the `entity_id`,
  # reading data from in_record and modifying out_record in place
  def apply_attributes(entity_id, in_record, out_record)
    @entity2attributes[entity_id].each do |attribute|
    # gnarly special case to avoid loops
    if attribute['name'] === 'preferredCtxAllele' then
      out_record['preferredCtxAllele'] = in_record['preferredCtxAllele']
      next
    end
    if in_record.key? attribute['name'] then
      out_record[attribute['name']] = convert_value(in_record[attribute['name']], attribute['dataType'])
    end
    end
  end
end

if __FILE__ == $0
  examples = DMWGExampleData.new('data/flattened')
  puts JSON.pretty_generate(examples.by_id['VarInterp001'])
end
