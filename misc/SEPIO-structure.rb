# Takes the (current as of 2016-12-06) DMWG interpretation model structure
# as json input and converts to a flatter form with entities rolling up
# the activities that produced them. This is done by:
#   bringing up the "used" dictionary, if present
#   bringing up the agent from "wasGeneratedBy" (without role)
#   bringing up "startedAtTime" and "endedAtTime"

require 'json'

def iterate(d)
  if d.is_a?(Hash)
    output = d.map { |k, v| [k, iterate(v)]}.to_h
    if output.has_key?('wasGeneratedBy')
      activity = output['wasGeneratedBy']
      activity.has_key?('used') && output['used'] = activity['used']
      if activity.has_key?('startedAtTime') then output['startedAtTime'] = activity['startedAtTime'] end
      if activity.has_key?('endedAtTime') then output['endedAtTime'] = activity['endedAtTime'] end
      if activity.has_key?('wasAssociatedWith') then output['wasAssociatedWith'] = activity['wasAssociatedWith'] end
      output.delete('wasGeneratedBy')
    end
    return output
  elsif d.is_a?(Array)
    return d.map { |e| iterate(e) }
  else
    begin
      output = d.clone
    rescue
      output = d
    end
    return output
  end
end

j = JSON.parse(ARGF.read)

#puts JSON.pretty_generate(iterate(j))
puts JSON.pretty_generate(iterate(j)['VarInterp001'])
