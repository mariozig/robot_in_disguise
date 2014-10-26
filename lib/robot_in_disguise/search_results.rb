require 'robot_in_disguise/enumerable'
require 'robot_in_disguise/post'

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
      self.attrs = attrs
    end

    private

    # @param attrs [Hash]
    # @return [Hash]
    def attrs=(attrs)
      # Clear out any existing attrs
      @attrs = attrs
      @attrs.fetch(:items, []).collect do |post|
        @collection << RobotInDisguise::Post.new(post)
      end
      @attrs
    end
  end
end
