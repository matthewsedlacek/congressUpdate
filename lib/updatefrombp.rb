class UpdateFromBP
    attr_reader :save_success

    def initialize(obj, doc)
        @doc = doc
        @obj = obj
        @save_success = false
        @update_data = Hash.new
        parse_info
        update_db
    end

    def parse_info
        info = @doc.css('.infobox')
        @update_data[:bp_link] = @doc.css('#firstHeading').text.gsub(" ", "_")
        widgets = info.css('.widget-row')
        links = info.css('a')
        
        unless links.empty?
            @link_map = links.map{|l| {url: l.attributes["href"].value, text: l.children[0].text}}
            parse_link_map
        end
        
        @update_data[:photo_url] = info.css('img')[0].attributes["src"].value
    end

    def parse_link_map
        @link_map.each do |link|
            case link[:text]
            when "Official website"
                @update_data[:official_url] = link[:url]
            when "Official Facebook"
                @update_data[:official_facebook] = strip_domain(link[:url])
            when "Official Twitter"
                @update_data[:official_twitter] = strip_domain(link[:url])    
            when "Campaign website"
                @update_data[:campaign_url] = link[:url]
            when "Campaign Facebook"
                @update_data[:campaign_facebook] = strip_domain(link[:url])
            when "Personal Twitter"
                @update_data[:personal_twitter] = strip_domain(link[:url])
            when "Campaign Twitter"
                @update_data[:campaign_twitter] = strip_domain(link[:url])
            end
        end
    end

    def strip_domain(url)
        url.split("/").last
    end

    def update_db
        @update_data[:update_status] = @update_data.length
        @save_success = @obj.update(@update_data)
    end
end