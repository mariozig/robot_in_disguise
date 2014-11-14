require 'faraday'
require 'robot_in_disguise/api'
require 'robot_in_disguise/error'
require 'robot_in_disguise/response/parse_json'
require 'robot_in_disguise/response/raise_error'

module RobotInDisguise
  class Client
    include RobotInDisguise::API

    attr_accessor :tfx_url, :proxy, :company_id, :debug

    # @param options [Hash]
    # @return [RobotInDisguise::Client]
    def initialize(options = {})
      options.each do |key, value|
        instance_variable_set("@#{key}", value)
      end
      yield(self) if block_given?
      validate_header_type!
    end

    # @return [String]
    def tfx_url
      @tfx_url ||= 'https://supportcontent.platform.intuit.com'
    end

    # @return [Hash]
    def headers
      @headers ||= {
        accept: 'application/json',
        user_agent: user_agent,
        companyid: company_id
      }
    end

    # @return [String]
    def user_agent
      @user_agent ||= "Robot in Disguise #{RobotInDisguise::VERSION}"
    end

    # @return [String]
    def company_id
      @company_id ||= ''
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
        # Handle error responses
        faraday.response :robot_in_disguise_raise_error
        # Parse JSON response bodies
        faraday.response :robot_in_disguise_parse_json
        # Log out if requested
        faraday.response :logger if debug == true
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
      @connection ||= Faraday.new(tfx_url, connection_options)
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

    # Ensures that all headers set during configuration are of a
    # valid type. Valid types are NilClass (empty) and String.
    #
    # @raise [RobotInDisguise::Error::ConfigurationError] Error is raised when
    #   supplied values are not a NilClass or String.
    def validate_header_type!
      headers.each do |header, value|
        valid_types = [NilClass, String]
        next if valid_types.include?(value.class)

        error_message = "Invalid #{header} specified: #{value.inspect} must of type: #{valid_types.join(', ')}"
        fail(RobotInDisguise::Error::ConfigurationError, error_message)
      end
    end
  end
end
