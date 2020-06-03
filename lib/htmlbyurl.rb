class HTMLByURL
    attr_reader :url, :logger
    attr_accessor :clean, :code, :body

    def initialize(url, logger = false)
        @url = url
        @logger = logger    
        @clean = false
        
        puts "GETting URL: #{url}" if @logger
        begin
          response = RestClient.get(url)
          @code = response.code
          @body = response.body
        rescue RestClient::BadRequest => e
          @code = e.http_code
        rescue RestClient::NotFound => e
          @code = e.http_code
          puts "not found!"
        else #check for 2xx also?
          @clean = true
        end
    end
end