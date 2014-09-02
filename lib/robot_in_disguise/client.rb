require 'faraday'

module RobotInDisguise

  # A client interface
  class Client

    # @return [Faraday::Connection] The Faraday HTTP connection.
    attr_reader :http

    # @return [Proc] The block used to configure faraday.
    attr_reader :faraday_configuration

    # Instantiate a new Client.
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
  end
end
