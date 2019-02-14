# frozen_string_literal: true

require 'active_record'
require 'json'

require 'zombie_battleground/api/models/match'
require 'zombie_battleground/api/validation_helper'
require 'zombie_battleground/api/responses/response_helper'

module ZombieBattleground
  class Api
    class Responses
      ##
      # Response validator for GetMatch
      class GetMatchResponse
        include ActiveModel::Validations
        include ZombieBattleground::Api::ValidationHelper
        include ZombieBattleground::Api::Responses::ResponseHelper

        ##
        # @!attribute [r] match
        # the match
        #
        # @return [ZombieBattleground::Api::Models::Match]
        #
        # @example
        #   response.match #=> ZombieBattleground::Api::Models::Match
        #
        # @api public
        attr_reader :match

        validate :match_is_a_match

        ##
        # Creates a new GetMatchResponse
        #
        # @param response [Faraday::Response] Faraday response from endpoint
        #
        # @return [ZombieBattleground::Api::GetMatchResponse]
        #
        # @example
        #   response = ZombieBattleground::Api::GetMatchResponse.new(faraday_response)
        #   # => ZombieBattleground::Api::GetMatchResponse
        #
        # @api public
        def initialize(response)
          handle_errors(response)

          @match = ZombieBattleground::Api::Models::Match.new(JSON.parse(response.body))
        end

        private

        ##
        # Validator for match attribute
        #
        # @return [void]
        #
        # @api private
        def match_is_a_match
          return if @match.is_a?(ZombieBattleground::Api::Models::Match) &&
                    @match.valid? &&
                    @match.errors.size.zero?

          errors.add(:match, 'match must be a Match')
        end
      end
    end
  end
end
