require_relative '../config/environment.rb'

num_candidates = Congressperson.count
limit = 25
servants = Congressperson.where(update_status: nil).limit(limit).offset(rand(num_candidates))
candidate = servants[0]
name = candidate.resolve_name
puts "Attempting GET from Ballotpedia for #{name}: #{candidate.id}"

bp_search = BPSearchAttempt.new(name)
if bp_search.result == "Match"
    result = UpdateFromBP.new(candidate, bp_search.doc)
    puts "Save: " + result.save_success.to_s
else
    puts "Malformed / Ambiguous"
end


# query = NewDataPrompt.new(old: "Steve_King", prompt: "What would you like to try instead?")
# puts query.response