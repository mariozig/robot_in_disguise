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
  end
end
