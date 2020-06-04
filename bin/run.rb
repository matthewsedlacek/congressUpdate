require_relative '../config/environment.rb'

num_candidates = Congressperson.count
limit = 25
servants = Congressperson.where(update_status: nil).limit(limit).offset(rand(num_candidates))
candidate = servants[0]

UpdateCandidate.new(candidate)