# frozen_string_literal: true

require 'active_record'
require 'json'

require 'zombie_battleground/api/models/deck'
require 'zombie_battleground/api/validation_helper'
require 'zombie_battleground/api/responses/response_helper'

module ZombieBattleground
  class Api
    class Responses
      ##
      # Response validator for GetDeck
      class GetDeckResponse
        include ActiveModel::Validations
        include ZombieBattleground::Api::ValidationHelper
        include ZombieBattleground::Api::Responses::ResponseHelper

        ##
        # @!attribute [r] deck
        # the deck
        #
        # @return [ZombieBattleground::Api::Models::Deck]
        #
        # @example
        #   response.deck #=> ZombieBattleground::Api::Models::Deck
        #
        # @api public
        attr_reader :deck

        validate :deck_is_a_deck

        ##
        # Creates a new GetDeckResponse
        #
        # @param response [Faraday::Response] Faraday response from endpoint
        #
        # @return [ZombieBattleground::Api::GetDeckResponse]
        #
        # @example
        #   response = ZombieBattleground::Api::GetDeckResponse.new(faraday_response)
        #   # => ZombieBattleground::Api::GetDeckResponse
        #
        # @api public
        def initialize(response)
          handle_errors(response)

          @deck = ZombieBattleground::Api::Models::Deck.new(JSON.parse(response.body))
        end

        private

        ##
        # Validator for deck attribute
        #
        # @return [void]
        #
        # @api private
        def deck_is_a_deck
          return if @deck.is_a?(ZombieBattleground::Api::Models::Deck) &&
                    @deck.valid? &&
                    @deck.errors.size.zero?

          errors.add(:deck, 'deck must be a Deck')
        end
      end
    end
  end
end
