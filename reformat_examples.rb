#!/usr/bin/ruby

# Purpose: create a nicer, nested version of the ClinGen DMWG example data
# Usage: ruby reformat_examples.rb [ids] [types]
#
# By default, reads in all the data from the 'data/flattened' directory
# of the repository, and prints out a json-encoded hash of elements by their id
#
# Optional arguments could be types (in which case all elements of that type
# are returned) or ids (so that those specific elements are returned)

require 'json'
require 'yaml'

class DMWGExampleData

  def by_id
    @id2example
  end

  def by_type
    @by_type
  end

  def attributes_by_entity
    @entity2attributes
  end

  def types
    @types
  end

  def initialize(data_dir)
    # an "auto hash" to hold all of the examples
    @id2example = {}
    @types = {}

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

    # Process the `Type` sheet
    @flattened['Type'].each do |e_id, e_rec|
      @types[e_id] = e_rec.select { |k, v| ['id', 'name', 'parentType', 'link', 'iri', 'description'].include? k }
      e_name = e_rec['name']
      parent = e_rec['parentType']
      while !!parent
        if !@entity2attributes[e_id].any? { |i| i['entityId'] == parent } then
          @entity2attributes[e_id] = @entity2attributes[parent] + @entity2attributes[e_id]
        end
        parent = @flattened['Type'][parent]['parentType']
      end
      @types[e_id]['attributes'] = @entity2attributes[e_id]
      if @flattened.key? e_name then
        # full fledged table for this entity (not a Statement subtype)
        @flattened[e_name].each do |id, rec|
          ex = @id2example[id] ||= {}
          ex['id'] = id
          ex['type'] = e_name
          apply_attributes(e_id, rec, ex)
        end
      end
    end

    # need to fix the types for Statement subclasses
    @flattened['Statement'].each do |d_id, d_rec|
      begin
        @id2example[d_id]['type'] = @flattened['Type'][d_rec['entityTypeId']]['name']
      rescue
        STDERR.puts "Error associating data id #{d_id} with entity type"
      end
    end

    # Now for the "join tables". Ugly hard-coding here
    ['_StatementAttribute',
     '_EvidenceLineAttribute',
     '_AgentAttribute',
     '_GeneticConditionAttribute',
     '_ContributionAttribute',
     '_ValueSetConcept',
    ].each do |sheet|
      @flattened[sheet].each_with_index do |da, i|
        data_id = da['subjectId']
        attribute_id = da['attributeId']
        attribute = @flattened['Attribute'][attribute_id]
        if attribute.nil? then
          STDERR.puts "Attribute #{attribute_id} does not appear to exist in line #{i} of #{sheet}!"
          next
        end
        (@id2example[data_id] ||= {})['id'] = data_id
        if value_exists? da['value'] then
          if attribute['cardinality'].end_with? '*' then
            (@id2example[data_id][attribute['name']] ||= []).push(convert_value(da['value'], attribute['dataType']))
          else
            @id2example[data_id][attribute['name']] = convert_value(da['value'], attribute['dataType'])
          end # value is list
        end # value exists
      end # each row in sheet
    end # each sheet

    # remove id from types that are only internal (not dereferenceable)
    @id2example.delete_if do |k, v|
      if ['Contribution'].include? v['type'] then
        v.delete('id')
        true
      else
        false
      end
    end

    # generate @by_type
    @by_type = {}
    by_id.each { |k, v| (by_type[v['type']] ||= []).push v }

    # check that all ids actually reference something
    if @by_type.has_key? nil and not @by_type[nil].empty? then
      STDERR.puts "!! WARNING: at least one id is used that does not reference an object:"
      @by_type[nil].each do |ref|
        STDERR.puts "!!   #{ref}"
      end
    end

  end # initialize

  private

  def convert_value(value, type)
    case type
    when 'String'
      value
    when 'Datetime'
      value
    when 'datetime'
      value
    when 'Date'
      value
    when 'int'
      value.to_i
    when 'float'
      value.to_f
    when 'boolean'
      !!value
    when 'yes/no/maybe'
      value.nil? ? nil : !!value
    when '???' # These should be fixed in the upstream data
      value
    when 'CodeableConcept'
      @id2example[value] || { 'id' => value }
    else
      @id2example[value] ||= { 'id' => value }
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
      if in_record.key?(attribute['name']) && value_exists?(in_record[attribute['name']]) then
        out_record[attribute['name']] = convert_value(in_record[attribute['name']], attribute['dataType'])
      end
    end
  end

  def value_exists?(value)
    !(value.nil? || value === "")
  end
end

if __FILE__ == $0
  examples = DMWGExampleData.new('data/flattened')
  if ARGV.empty?
    puts JSON.pretty_generate(examples.by_id)
  else
    by_id = examples.by_id
    by_type = examples.by_type
    ARGV.each do |arg|
      if by_id.key? arg
        puts JSON.pretty_generate({ arg => by_id[arg] })
      elsif by_type.key? arg
        puts JSON.pretty_generate({ arg => by_type[arg] })
      else
        puts "// unable to find #{arg} as a type or id"
      end
      puts ";"
    end
  end
end
