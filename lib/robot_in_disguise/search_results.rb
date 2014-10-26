require 'robot_in_disguise/enumerable'

module RobotInDisguise
  class SearchResults
    include RobotInDisguise::Enumerable

    # @return [Hash]
    attr_reader :attrs

    # Initializes a new SearchResults object
    #
    # @param attrs [Hash]
    # @param request [RobotInDisguise::Request]
    # @return [RobotInDisguise::SearchResults]
    def initialize(attrs, request)
      @client = request.client
      @request_method = request.request_method
      @path = request.path
      @options = request.options
      @collection = []
      @attrs = attrs
    end
  end
end
