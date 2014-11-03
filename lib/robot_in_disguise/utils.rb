require 'robot_in_disguise/request'

module RobotInDisguise
  module Utils
    private
      # Take a URI or string and return it's content_id
      #
      # @param object [String, URI, RobotInDisguise::Post] A String, URI, or Post object.
      # @return [String]
      def extract_content_id(object)
        case object
        when ::String
          object
        when URI
          object.path.split('/').last.to_s
        when RobotInDisguise::Post
          object.content_id
        end
      end

      # @param request_method [Symbol]
      # @param path [String]
      # @param options [Hash]
      # @param klass [Class]
      def perform_with_object(request_method, path, options, klass)
        request = RobotInDisguise::Request.new(self, request_method, path, options)
        request.perform_with_object(klass)
      end
  end
end
