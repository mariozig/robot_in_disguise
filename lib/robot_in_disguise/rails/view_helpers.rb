require 'robot_in_disguise/post'
require 'robot_in_disguise/utils'

module RobotInDisguise
  module ViewHelpers
    # TODO: Clean up this implementation
    def tfx_post_for(content_id, _parse_link = nil, &block)
      content_id = RobotInDisguise::Utils.extract_content_id(post)
      post = RobotInDisguise::Post.new(content_id)
      block.call(post) if block_given?
    end
  end
end
