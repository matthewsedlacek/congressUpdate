require_relative '../config/environment.rb'

# # num_candidates = Congressperson.count
# # limit = 25
# # servants = Congressperson.where(update_status: nil).limit(limit).offset(rand(num_candidates))
# # name = servants[0].candidate_name
# name = "Steve_King"
# puts "Attempting GET from Ballotpedia for #{name}"


new_search = NewBPSearchAttempt.new("Ted_Cruz")

# query = NewDataPrompt.new(old: "Steve_King", prompt: "What would you like to try instead?")
# puts query.response