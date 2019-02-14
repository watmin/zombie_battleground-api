# frozen_string_literal: true

require 'active_record'
require 'json'

require 'zombie_battleground/api/models/card'
require 'zombie_battleground/api/validation_helper'
require 'zombie_battleground/api/responses/response_helper'

module ZombieBattleground
  class Api
    ##
    # Response validator for GetCard
    class GetCardResponse
      include ActiveModel::Validations
      include ZombieBattleground::Api::ValidationHelper
      include ZombieBattleground::Api::ResponseHelper

      attr_reader :card

      validate :card_is_a_card

      def initialize(response)
        handle_errors(response)

        @card = ZombieBattleground::Api::Card.new(JSON.parse(response.body))
      end

      def card_is_a_card
        return if @card.is_a?(ZombieBattleground::Api::Card) &&
                  @card.valid? &&
                  @card.errors.size.zero?

        errors.add(:card, 'card must be a Card')
      end
    end
  end
end
