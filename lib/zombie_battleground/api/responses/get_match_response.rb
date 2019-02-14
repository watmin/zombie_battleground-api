# frozen_string_literal: true

require 'active_record'
require 'json'

require 'zombie_battleground/api/models/match'
require 'zombie_battleground/api/validation_helper'
require 'zombie_battleground/api/responses/response_helper'

module ZombieBattleground
  class Api
    ##
    # Response validator for GetMatch
    class GetMatchResponse
      include ActiveModel::Validations
      include ZombieBattleground::Api::ValidationHelper
      include ZombieBattleground::Api::ResponseHelper

      attr_reader :match

      validate :match_is_a_match

      def initialize(response)
        handle_errors(response)

        @match = ZombieBattleground::Api::Match.new(JSON.parse(response.body))
      end

      def match_is_a_match
        return if @match.is_a?(ZombieBattleground::Api::Match) &&
                  @match.valid? &&
                  @match.errors.size.zero?

        errors.add(:match, 'match must be a Match')
      end
    end
  end
end
