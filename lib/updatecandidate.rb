class UpdateCandidate
    attr_reader :success

    def initialize(obj)
        @obj = obj
        @success = false
        update(@obj.resolve_name)
    end

    def update(name_try)
        puts "Attempting GET from Ballotpedia for #{name_try}: #{@obj.id}"

        bp_search = BPSearchAttempt.new(name_try) #returns object, with result == "Match" || "Ambiguous" || "Malformed"

        case bp_search.result
            when "Match"
                result = UpdateFromBP.new(@obj, bp_search.doc)
                unless result.save_success
                    puts "Could not save id: #{@obj.id}"
                    sleep 10
                else
                    puts "Saved id: #{@obj.id}!"
                    @obj.update(candidate_name: name_try.gsub("_", " "))
                    sleep 2
                end
            when "Ambiguous"

            when "Malformed"
                query = NewDataPrompt.new(old: name_try, prompt: "What would you like to try instead?")
                case query.response
                when "destroy"
                    @obj.destroy #use wisely    #delete associations in future if necessary
                when "cancel"
                    #let exit gracefully
                else
                    update(query.response) #loop and attempt with new entry
                end
        end
    end
end