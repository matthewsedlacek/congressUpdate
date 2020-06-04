class UpdateFromBP
    attr_reader :save_success

    def initialize(obj, doc)
        @doc = doc
        @obj = obj
        @save_success = false
        @update_data = Hash.new
        parse_info
    end

    def parse_info
        info = @doc.css('.infobox')
        @update_data[:candidate_name] = @doc.css('#firstHeading').text      #|| @obj.candidate_name
        widgets = info.css('.widget-row')
        links = info.css('a')
        
        unless links.empty?
            @link_map = links.map{|l| {url: l.attributes["href"].value, text: l.children[0].text}}
            parse_link_map
        end
        
        @update_data[:photo_url] = info.css('img')[0].attributes["src"].value
        binding.pry
    end

    def parse_link_map
        @link_map.each do |link|
            case link[:text]
            when "Official website"
                @update_data[:official_url] = link[:url]
            when "Official Facebook"
                @update_data[:official_facebook] = link[:url]
            when "Official Twitter"
                @update_data[:official_twitter] = link[:url]    
            when "Campaign website"
                @update_data[:campaign_url] = link[:url]
            when "Campaign Facebook"
                @update_data[:campaign_facebook] = link[:url]
            when "Personal Twitter"
                @update_data[:personal_twitter] = link[:url]
            when "Campaign Twitter"
                @update_data[:campaign_twitter] = link[:url]
            end
        end
    end
end