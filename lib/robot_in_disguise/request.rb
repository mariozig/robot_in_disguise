module RobotInDisguise
  class Request
    attr_accessor :client, :request_method, :path, :options

    # @param client [RobotInDisguise::Client]
    # @param request_method [String, Symbol]
    # @param path [String]
    # @param options [Hash]
    # @return [RobotInDisguise::Request]
    def initialize(client, request_method, path, options = {})
      @client = client
      @request_method = request_method.to_sym
      @path = path
      @options = options
    end

    # @return [Hash]
    def perform
      @client.send(@request_method, @path, @options).body
    end

    # @param klass [Class]
    # @return [Object]
    def perform_with_object(klass)
      klass.new(perform)
    end
  end
end
