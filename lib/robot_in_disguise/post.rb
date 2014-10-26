require 'robot_in_disguise/request'

module RobotInDisguise
  class Post
    # @return [Hash]
    attr_reader :attrs

    # Initializes a new post object
    #
    # @param attrs [Hash]
    # @return [RobotInDisguise::Post]
    def initialize(attrs = {})
      @attrs = attrs || {}
    end

    # @return [String] The post's full title
    def title
    end
  end
end
