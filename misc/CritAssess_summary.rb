require '../reformat_examples.rb'
require 'set'

$dmwg_examples = DMWGExampleData.new('../data/flattened')

assessments_by_criterion =
  $dmwg_examples.by_type['CriterionAssessment'].select {
    |x| x.key?('criterion') && x.key?('outcome')
  }.group_by { |x| x['criterion']['id'] }

puts "Criterion\tMet\tNot Met\tTotal"

assessments_by_criterion.each do |crit, cas|
  data_types = Set.new
  cas.each do |ca|
    ca.fetch('evidence', []).each do |evl|
      evl.fetch('information', []).each { |sd| data_types << sd['type'] }
    end
  end
  data_types = data_types.to_a.sort.join ", "
  puts [crit,
        cas.select {|x| x['outcome'] == 'CG-criterion-outcome:met'}.length,
        cas.select {|x| x['outcome'] == 'CG-criterion-outcome:met'}.length,
        cas.length,
        data_types
      ].join "\t"
end
