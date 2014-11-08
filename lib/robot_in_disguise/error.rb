module RobotInDisguise
  class Error < StandardError
    # Initializes a new Error object. Aw yiss.
    #
    # @param message [Exception, String]
    # @return [RobotInDisguise::Error]
    def initialize(message = '')
      super(message)
    end

    class << self
      # Create a new error from an HTTP response
      #
      # @param response [Faraday::Response]
      # @return [RobotInDisguise::Error]
      def from_response(response)
        message = grab_error(response.body)
        new(message)
      end

      # @return [Hash]
      def errors # rubocop:disable Metrics/MethodLength
        {
          400 => RobotInDisguise::Error::BadRequest,
          401 => RobotInDisguise::Error::Unauthorized,
          403 => RobotInDisguise::Error::Forbidden,
          404 => RobotInDisguise::Error::NotFound,
          406 => RobotInDisguise::Error::NotAcceptable,
          408 => RobotInDisguise::Error::RequestTimeout,
          422 => RobotInDisguise::Error::UnprocessableEntity,
          500 => RobotInDisguise::Error::InternalServerError,
          502 => RobotInDisguise::Error::BadGateway,
          504 => RobotInDisguise::Error::GatewayTimeout
        }
      end

      private

      # Error text from the response body or an empty string
      #
      # @param response_body [String]
      # @return [String]
      def grab_error(response_body)
        response_body || ''
      end
    end

    # 4xx Client Errors:
    # Intended for cases in which the client seems to have errored.ntended for cases in which the client seems to have errored.
    # Raised when TFX returns a 4xx HTTP status code
    ClientError = Class.new(self)

    # Raised when TFX returns the HTTP status code 400
    BadRequest = Class.new(ClientError)

    # Raised when TFX returns the HTTP status code 401
    Unauthorized = Class.new(ClientError)

    # Raised when TFX returns the HTTP status code 403
    Forbidden = Class.new(ClientError)

    # Raised when TFX returns the HTTP status code 404
    NotFound = Class.new(ClientError)

    # Raised when TFX returns the HTTP status code 406
    NotAcceptable = Class.new(ClientError)

    # Raised when TFX returns the HTTP status code 408
    RequestTimeout = Class.new(ClientError)

    # Raised when TFX returns the HTTP status code 422
    UnprocessableEntity = Class.new(ClientError)

    # 5xx Sever Errors:
    # The server failed to fulfill an apparently valid request.
    # Raised when TFX returns a 5xx HTTP status code
    ServerError = Class.new(self)

    # Raised when TFX returns the HTTP status code 500
    InternalServerError = Class.new(ServerError)

    # Raised when TFX returns the HTTP status code 502
    BadGateway = Class.new(ServerError)

    # Raised when TFX returns the HTTP status code 504
    GatewayTimeout = Class.new(ServerError)
  end
end
