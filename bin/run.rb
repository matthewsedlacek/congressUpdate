require_relative '../config/environment.rb'

# num_candidates = Congressperson.count
# limit = 25
# servants = Congressperson.where(update_status: nil).limit(limit).offset(rand(num_candidates))
# name = servants[0].candidate_name
name = "Kamala_Harris"
puts "Attempting GET from Ballotpedia for #{name}"


frankly = HTMLByURL.new("https://www.ballotpedia.org/" + name, true)

unless frankly.code == 404
    doc = Nokogiri::HTML(frankly.body)
    binding.pry
    puts "all done, that hurt"
end