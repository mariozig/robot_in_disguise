module RobotInDisguise
  class SearchResults
    # @return [Hash]
    attr_reader :attrs

    # Initializes a new SearchResults object
    #
    # @param request [RobotInDisguise::Request]
    # @return [RobotInDisguise::SearchResults]
    def initialize(response, request)
      @client = request.client
      @request_method = request.request_method
      @path = request.path
      @options = request.options
      @collection = []
      @attrs = response
    end
  end
end
