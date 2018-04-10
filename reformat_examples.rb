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

  def data_by_id
    @data_by_id
  end

  def data_by_entity_type
    @data_by_entity_type
  end

  def attributes_by_entity_id
    @attributes_by_entity_id
  end

  # the hash of entity types by entity id, containing only a subset of top level Type attributes
  def types_by_entity_id
    @types_by_entity_id
  end

  def initialize(data_dir)
    # an "auto hash" to hold all of the examples
    @data_by_id = {}

    #this uses the internal ids (overwritten by @id when available)
    # FIXME- should we just change 'id' in the sheets to contain '@id'?
    @id2example = {}

    @types_by_entity_id = {}

    # slurp in all the json files in the `data_dir` and initialize/load the json version of each file hash keyed by json file basename
    @flattened = Hash[Dir["#{data_dir}/*.json"].collect { |jsonfile|
      [File.basename(jsonfile, '.json'), JSON.parse(File.read(jsonfile))]
    }]

    # Read in the Attribute sheet and initialize the @attributes_by_entity_id hash
    @attributes_by_entity_id = Hash.new { |hash, key| hash[key] = [] }
    @flattened['Attribute'].each do |a_id, a_rec|
      # collect up all attributes for an entityId
      @attributes_by_entity_id[a_rec['entityId']].push(a_rec)
    end
    @attributes_by_entity_id.each do |e_id, a_recs|
      a_recs.sort_by! { |x| x['precedence'] || 0}
    end

    # Process the `Type` sheet by combining all parent type attributes and then adding the full set of attributes to each type element.
    @flattened['Type'].each do |e_id, e_rec|

      # add the type for the current 'Type' record being processed, select a subset of the Type's attributes.
      @types_by_entity_id[e_id] = e_rec.select { |k, v| ['id', 'name', 'parentType', 'link', 'iri', 'description'].include? k }
      
      #entity name
      e_name = e_rec['name']
      # parent type entityId
      parent = e_rec['parentType']
      
      # loop through ancestry (parents) and add attributes, so that each entity has a full set.
      while !!parent
        #if the parent entity is found with it's collection of attributes...
        if !@attributes_by_entity_id[e_id].any? { |i| i['entityId'] == parent } then
          # add the parent attributes to the descendant entity's list of attributes.
          @attributes_by_entity_id[e_id] = @attributes_by_entity_id[parent] + @attributes_by_entity_id[e_id]
        end
        # parent's parent if available
        parent = @flattened['Type'][parent]['parentType']
      end

      # attaches a full collection of attributes to the @types_by_entity_id entity element being processed.
      @types_by_entity_id[e_id]['attributes'] = @attributes_by_entity_id[e_id]
      
      # if a file exists for the given entity name then process it...
      if @flattened.key? e_name then

        # full fledged table for this entity (not a Statement or DomainEntity subtype) - is this still right? or does it include all?
        @flattened[e_name].each do |id, rec|
          ex = @id2example[id] ||= {}
          # FIXME-- this may be better fixed in the sheets document
          ex['id'] = rec['@id'] || id
          ex['type'] = e_name
          apply_attributes(e_id, rec, ex)
        end

      end

    end

    # fix the types_by_entity_id for Statement and DomainEntity subclasses
    ['Statement', 'DomainEntity'].each do |superclass|

      @flattened[superclass].each do |d_id, d_rec|
        begin
          @id2example[d_id]['type'] = @flattened['Type'][d_rec['entityTypeId']]['name']
        rescue
          STDERR.puts "Error associating data id #{d_id} with entity type"
        end
      end
      
    end

    # Now for the "join tables". Ugly hard-coding here
    [
     '_DomainEntityAttribute',
     '_EvidenceLineAttribute',
     '_IdentifierSystemAttribute',
     '_StatementAttribute',
     '_UserLabelAttribute',
     '_ValueSetAttribute',
    ].each do |sheet|
      if !@flattened.has_key? sheet
         STDERR.puts "ERROR: expected sheet #{sheet}, but none found"
         next
      end
      @flattened[sheet].each_with_index do |da, i|
        data_id = da['subjectId']
        attribute_id = da['attributeId']
        attribute = @flattened['Attribute'][attribute_id]
        if attribute.nil? then
          STDERR.puts "Attribute #{attribute_id} does not appear to exist in line #{i} of #{sheet}!"
          next
        end
        (@id2example[data_id] ||= {})['id'] ||= data_id
        if value_exists? da['value'] then
          if ['A137', 'A169', 'A171'].include? attribute['id'] then
            # special case relatedCanonicalAllele to avoid loop...
            @id2example[data_id][attribute['name']] = da['value']
          elsif attribute['cardinality'].end_with? '*' then
            (@id2example[data_id][attribute['name']] ||= []).push(convert_value(da['value'], attribute['dataType']))
          else
            @id2example[data_id][attribute['name']] = convert_value(da['value'], attribute['dataType'])
          end # value is list
        end # value exists
      end # each row in sheet
    end # each 'join-table' sheet

    @flattened['__labels'].each do |subjectLabel|
      sId = subjectLabel['subjectId']
      label = subjectLabel['label']
      if sId.empty? or label.empty?
        STDERR.puts "blank value in __labels sheet: [#{sId}]: [#{label}]"
        next
      end
      if !@id2example.has_key? sId
        STDERR.puts "attempted to apply label '#{label}' to '#{sId}', but no such object exists"
        next
      end
      subj = @id2example[sId]
      if subj.has_key? 'label'
        STDERR.puts "attempted to apply a label '#{label}' to '#{sId}', which already has label '#{subj['label']}'"
      end
      @id2example[sId]['label'] = label
    end # each row of __labels sheet

    # FIXME - this is kludgy
    @id2example.each do |id, ex|
      @data_by_id[ex['id']] = ex
    end

    # remove id from types_by_entity_id that are only internal (not dereferenceable)
    @id2example.delete_if do |k, v|
      if ['Contribution'].include? v['type'] then
        v.delete('id')
        true
      else
        false
      end
    end

    # generate @data_by_entity_type
    @data_by_entity_type = {}
    data_by_id.each { |k, v| (data_by_entity_type[v['type']] ||= []).push v }

    # check that all ids actually reference something
    if @data_by_entity_type.has_key? nil and not @data_by_entity_type[nil].empty? then
      STDERR.puts "!! WARNING: at least one id is used that does not reference an object:"
      @data_by_entity_type[nil].each do |ref|
        STDERR.puts "!!   #{ref}"
      end
    end

  end # initialize

  private

  # uses the data types in the spread sheets to convert them into more stable data types in json.
  def convert_value(value, type)
    case type
    when 'string'
      value
    when 'Datetime'
      value
    when 'datetime'
      value
    when 'Date'
      value
    when 'integer'
      value.to_i
    when 'number'
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
    @attributes_by_entity_id[entity_id].each do |attribute|
      # gnarly special cases to avoid loops
      if attribute['name'] === 'preferredCtxAllele' then
        out_record['preferredCtxAllele'] = in_record['preferredCtxAllele']
        next
      end
      if attribute['name'] === 'producedBy' and in_record.has_key? 'producedBy' then
        out_record['producedBy'] = in_record['producedBy']
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

# __FILE__ is the name of this file "reformat_examples.rb"
# $0 is the name of the file that is being run
# so this next block is only executed if this is the file being executed directly, the root file being called.
# the DMWG examples flattened in the data/flattened directory are read into the structures provided by DMWGExamples
# if args are passed on the command line they will be used to print the json for the type or id that matches to the console
if __FILE__ == $0
  examples = DMWGExampleData.new('data/flattened')
  if ARGV.empty?
    puts JSON.pretty_generate(examples.data_by_id)
    #puts YAML.dump(examples.data_by_id)
  else
    data_by_id = examples.data_by_id
    data_by_entity_type = examples.data_by_entity_type
    ARGV.each do |arg|
      if data_by_id.key? arg
        puts JSON.pretty_generate({ arg => data_by_id[arg] })
      elsif data_by_entity_type.key? arg
        puts JSON.pretty_generate({ arg => data_by_entity_type[arg] })
      else
        puts "// unable to find #{arg} as a type or id"
      end
      puts ";"
    end
  end
end
