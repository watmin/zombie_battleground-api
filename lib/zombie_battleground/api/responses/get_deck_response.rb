# frozen_string_literal: true

require 'active_record'
require 'json'

require 'zombie_battleground/api/models/deck'
require 'zombie_battleground/api/validation_helper'
require 'zombie_battleground/api/responses/response_helper'

module ZombieBattleground
  class Api
    ##
    # Response validator for GetDeck
    class GetDeckResponse
      include ActiveModel::Validations
      include ZombieBattleground::Api::ValidationHelper
      include ZombieBattleground::Api::ResponseHelper

      attr_reader :deck

      validate :deck_is_a_deck

      def initialize(response)
        handle_errors(response)

        @deck = ZombieBattleground::Api::Deck.new(JSON.parse(response.body))
      end

      def deck_is_a_deck
        return if @deck.is_a?(ZombieBattleground::Api::Deck) &&
                  @deck.valid? &&
                  @deck.errors.size.zero?

        errors.add(:deck, 'deck must be a Deck')
      end
    end
  end
end
