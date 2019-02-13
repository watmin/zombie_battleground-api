# frozen_string_literal: true

module ZombieBattleground
  module Api
    class Errors
      class BadRequest < StandardError; end
      class InternalServerError < StandardError; end
      class InvalidInput < StandardError; end
      class NotFound < StandardError; end
      class ServiceUnavailable < StandardError; end
      class UnknownResponse < StandardError; end

      ##
      # Creates an error with the Faraday response and the context for the error
      class InvalidResponse < StandardError
        def initialize(response, context)
          @response = response
          @context = context
          super(context.errors.messages.to_s)
        end
      end
    end
  end
end
