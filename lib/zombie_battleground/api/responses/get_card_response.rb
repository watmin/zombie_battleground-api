# frozen_string_literal: true

require 'active_record'
require 'json'

require 'zombie_battleground/api/models/card'
require 'zombie_battleground/api/validation_helper'
require 'zombie_battleground/api/responses/response_helper'

module ZombieBattleground
  class Api
    ##
    # Namespace for Responses
    class Responses
      ##
      # Response validator for GetCard
      class GetCardResponse
        include ActiveModel::Validations
        include ZombieBattleground::Api::ValidationHelper
        include ZombieBattleground::Api::Responses::ResponseHelper

        ##
        # @!attribute [r] card
        # the card
        #
        # @return [ZombieBattleground::Api::Deck]
        #
        # @example
        #   response.card #=> ZombieBattleground::Api::Deck
        #
        # @api public
        attr_reader :card

        validate :card_is_a_card

        ##
        # Creates a new GetCardResponse
        #
        # @param response [Faraday::Response] Faraday response from endpoint
        #
        # @return [ZombieBattleground::Api::GetCardResponse]
        #
        # @example
        #   response = ZombieBattleground::Api::GetCardResponse.new(faraday_response)
        #   # => ZombieBattleground::Api::GetCardResponse
        #
        # @api public
        def initialize(response)
          handle_errors(response)

          @card = ZombieBattleground::Api::Models::Card.new(JSON.parse(response.body))
        end

        private

        ##
        # Validator for card attribute
        #
        # @return [void]
        #
        # @api private
        def card_is_a_card
          return if @card.is_a?(ZombieBattleground::Api::Models::Card) &&
                    @card.valid? &&
                    @card.errors.size.zero?

          errors.add(:card, 'card must be a Card')
        end
      end
    end
  end
end
