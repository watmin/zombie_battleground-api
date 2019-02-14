# frozen_string_literal: true

module ZombieBattleground
  class Api
    ##
    # Error classes for the API
    class Errors
      ##
      # Raised if the endpoint responds with a 400
      class BadRequest < StandardError; end

      ##
      # Raised if the endpoint responds with a 500
      class InternalServerError < StandardError; end

      ##
      # Raised if a request validation fails
      class InvalidInput < StandardError; end

      ##
      # Raised if the endpoint responds with a 404
      class NotFound < StandardError; end

      ##
      # Raised if the endpoint responds with a 503
      class ServiceUnavailable < StandardError; end

      ##
      # Raised if the response fails validation
      class UnknownResponse < StandardError; end

      ##
      # Creates an error with the Faraday response and the context for the error
      class InvalidResponse < StandardError
        ##
        # Creates an exception class with the Faraday response and error context
        #
        # @param response [Faraday::Response] response from the endpoint
        # @param context [Class] parsed response object
        #
        # @return [ZombieBattleground::Api::Errors::InvalidResponse]
        #
        # @api private
        def initialize(response, context)
          @response = response
          @context = context
          super(context.errors.messages.to_s)
        end
      end
    end
  end
end
