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
      define_attribute_methods(@attrs.keys)
    end

    private

    # Dynamically adds methods to the Post class keyed
    # off of TFX's response
    #
    # @param post_attributes [Array] A list of all attributes
    def define_attribute_methods(post_attributes)
      post_attributes.each do |post_attr|
        post_attr = post_attr.to_sym
        self.class.send(:define_method, post_attr) { @attrs[post_attr] }
      end
    end
  end
end
