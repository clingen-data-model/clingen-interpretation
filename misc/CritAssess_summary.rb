require '../reformat_examples.rb'
require 'set'

$dmwg_examples = DMWGExampleData.new('../data/flattened')

assessments_by_criterion =
  $dmwg_examples.by_type['CriterionAssessment'].select {
    |x| x.key?('criterion') && x.key?('outcome')
  }.group_by { |x| x['criterion']['cg:id'] }

puts "Criterion\tMet\tInsufficient\tRefuted\tTotal"

assessments_by_criterion.each do |crit, cas|
  data_types = Set.new
  cas.each do |ca|
    ca.fetch('hasSupportingEvidence', []).each do |evl|
      evl.fetch('supportingData', []).each { |sd| data_types << sd['cg:type'] }
    end
  end
  data_types = data_types.to_a.sort.join ", "
  puts [crit,
        cas.select {|x| x['outcome'] == 'CG:MET'}.length,
        cas.select {|x| x['outcome'] == 'CG:INSUFFICIENT'}.length,
        cas.select {|x| x['outcome'] == 'CG:REFUTE'}.length,
        cas.length,
        data_types
      ].join "\t"
end
