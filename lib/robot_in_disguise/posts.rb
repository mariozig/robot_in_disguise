require 'robot_in_disguise/post'
require 'robot_in_disguise/utils'

module RobotInDisguise
  module Posts
    include RobotInDisguise::Utils

    # Returns a Post
    #
    # @see https://tfx/swagger/docs/somewhere
    # @rate_limited No
    # @return [RobotInDisguise::Post] The requested Post.
    # @param post [Integer, String, URI, RobotInDisguise::Post] A Post ID, URI, or object.
    # @param options [Hash] An optional set of options.
    def post(post, options = {})
      perform_with_object(:get, "/v2/search/posts/#{extract_content_id(post)}", options, RobotInDisguise::Post)
    end
  end
end
