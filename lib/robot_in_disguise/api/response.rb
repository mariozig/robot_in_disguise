module RobotInDisguise::API
  # Generic response from API
  class Response
    # @return [RobotInDisguise::Client] The client used to generate the response.
    attr_reader :client

    # @return [String, Hash] The response body from TFX.
    attr_reader :body
    
    def initialize(faraday_response, client)
      @client = client
      @response = faraday_response

      @response.on_complete do 
      end
    end
  end
end
