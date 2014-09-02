require 'faraday'

module RobotInDisguise

  # A client interface
  class Client

    # @return [Faraday::Connection] The Faraday HTTP connection.
    attr_reader :http

    # @return [Proc] The block used to configure faraday.
    attr_reader :faraday_configuration

    # Instantiate a new RobotInDisguise::Client.
    # @param url [#to_s] The URL used for building a connection. Can be overridden.
    # @yieldparam [Faraday::Connection] The setup for the faraday connection.
    # @return RobotInDisguise::Client
    def initialize(url='http://tfx', &block)
      @faraday_configuration = block      
      @http = Faraday.new(url) do |faraday|
        block = lambda{ |f| f.adapter :net_http_persistent } unless block
        block.call faraday
      end
    end    
    
    def search(collection, query, options={})
      send_request :get, [collection], { query: options.merge({ q: query }),
                                         response: API::CollectionResponse }
    end

    def send_request(method, path, options={})
      headers = options.fetch(:headers, {})
      headers['User-Agent'] = "robot_in_disguise/#{RobotInDisguise::VERSION}"
      headers['Accept'] = 'application/json' if method == :get
      
      query_string = options.fetch(:query, {})
     
      path = ['/v2', URI.escape(s.to_s)].join('/')

      body = options.fetch(:body, '')

      http_response = http.send(method) do |request|
        request.url path, query_string
      end

      response_class = options.fetch(:response, API::Response)
      response_class.new(http_response, self)
    end
  end
end
