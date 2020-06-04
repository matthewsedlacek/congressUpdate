class NewBPSearchAttempt
    attr_reader :result, :doc

    def initialize(name)
        @name = name
        attempt
    end
    
    def attempt
        resp = HTMLByURL.new("https://www.ballotpedia.org/" + @name, true)

        unless resp.code == 404
            @doc = Nokogiri::HTML(resp.response)
            
            ambig = doc.css('#disambig')
            
            ambig.empty? ? @result = "Match" : @result = "Ambiguous"
        else
            @result = "Malformed"
        end
    end
end