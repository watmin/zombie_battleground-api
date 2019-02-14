# frozen_string_literal: true

require 'zombie_battleground/api/errors'

module ZombieBattleground
  class Api
    class Responses
      ##
      # Provides generic methods for response validator classes
      module ResponseHelper
        private

        ##
        # Raises errors as needed from the response status code
        #
        # @param response [Faraday::Response] Faraday response from endpoint
        #
        # @return [void]
        #
        # @raise [ZombieBattleground::Api::Errors::NotFound, ZombieBattleground::Api::Errors::ServiceUnavailable,
        #         ZombieBattleground::Api::Errors::BadRequest, ZombieBattleground::Api::Errors::InternalServerError,
        #         ZombieBattleground::Api::Errors::UnknownResponse]
        #
        # @api private
        def handle_errors(response)
          return if response.status == 200

          case response.status
          when 404
            raise ZombieBattleground::Api::Errors::NotFound, response.body
          when 503
            raise ZombieBattleground::Api::Errors::ServiceUnavailable, response.body
          when 400..499
            raise ZombieBattleground::Api::Errors::BadRequest, response.body
          when 500..599
            raise ZombieBattleground::Api::Errors::InternalServerError, response.body
          end

          raise ZombieBattleground::Api::Errors::UnknownResponse, response.body
        end
      end
    end
  end
end
