require 'robot_in_disguise/post'
require 'robot_in_disguise/utils'

module RobotInDisguise
  module Posts
    include RobotInDisguise::Utils

    # Returns a Post
    #
    # @see http://tfx/post/docs/once/they/are/up
    # @return [RobotInDisguise::Post] The requested Post.
    # @param post [String, URI, RobotInDisguise::Post] A Post ID, URI, or object.
    # @param options [Hash] An optional set of options.
    def post(post, options = {})
      url = "/v2/search/posts/#{extract_content_id(post)}"
      perform_with_object(:get, url, options, RobotInDisguise::Post)
    end
  end
end
