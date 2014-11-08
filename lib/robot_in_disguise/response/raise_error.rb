require 'faraday'
require 'robot_in_disguise/error'

module RobotInDisguise
  module Response
    class RaiseError < Faraday::Response::Middleware
      def on_complete(response)
        status_code = response.status.to_i
        klass = RobotInDisguise::Error.errors[status_code]
        return unless klass

        fail(klass.from_response(response))
      end
    end
  end
end

Faraday::Response.register_middleware robot_in_disguise_raise_error: RobotInDisguise::Response::RaiseError
