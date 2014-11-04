require 'faraday'
require 'robot_in_disguise/api'
require 'robot_in_disguise/response/parse_json'

module RobotInDisguise
  class Client
    include RobotInDisguise::API

    attr_accessor :tfx_url, :proxy

    # @param options [Hash]
    # @return [RobotInDisguise::Client]
    def initialize(options = {})
      default_options = {
        tfx_url: 'https://transformation-production.ush.a.intuit.com'
      }
      options = default_options.merge(options)

      options.each do |key, value|
        instance_variable_set("@#{key}", value)
      end
      yield(self) if block_given?
    end

    # @return [String]
    def user_agent
      @user_agent ||= "Robot in Disguise #{RobotInDisguise::VERSION}"
    end

    # @return [Hash]
    def headers
      {
        accept: 'application/json',
        user_agent: user_agent
      }
    end

    # @return [Hash]
    def connection_options
      @connection_options ||= {
        builder: middleware,
        headers: headers,
        request: {
          open_timeout: 10,
          timeout: 30
        },
        proxy: proxy
      }
    end

    # @note Faraday's middleware stack implementation is comparable to that of
    #  Rack middleware.  The order of middleware is important: the first
    #  middleware on the list wraps all others, while the last middleware is
    #  the innermost one.
    # @see https://github.com/technoweenie/faraday#advanced-middleware-usage
    # @see http://mislav.uniqpath.com/2011/07/faraday-advanced-http/
    # @return [Faraday::RackBuilder]
    def middleware
      @middleware ||= Faraday::RackBuilder.new do |faraday|
        # Encodes as "application/x-www-form-urlencoded" if not already encoded
        faraday.request :url_encoded
        # # Handle error responses
        # faraday.response :robot_in_disguise_raise_error
        # Parse JSON response bodies
        faraday.response :robot_in_disguise_parse_json
        # Set default HTTP adapter
        faraday.adapter :net_http
      end
    end

    # Perform an HTTP GET request
    def get(path, params = {})
      request(:get, path, params)
    end

    private

    def connection
      @connection ||= Faraday.new(@tfx_url, connection_options)
    end

    def request(method, path, params = {}, headers = {})
      connection.send(method.to_sym, path, params) do |request|
        request.headers.update(headers)
      end
      # TODO: those
      # rescue Faraday::Error::TimeoutError, Timeout::Error => error
      #   raise(RobotInDisguise::Error::RequestTimeout.new(error))
      # rescue Faraday::Error::ClientError, JSON::ParserError => error
      #   raise(RobotInDisguise::Error.new(error))
    end
  end
end
