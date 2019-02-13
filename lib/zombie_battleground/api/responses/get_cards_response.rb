# frozen_string_literal: true

require 'active_record'
require 'json'

require 'zombie_battleground/api/models/card'
require 'zombie_battleground/api/validation_helper'
require 'zombie_battleground/api/responses/response_helper'

module ZombieBattleground
  module Api
    ##
    # Response validator for GetCards
    class GetCardsResponse
      include ActiveModel::Validations
      include ZombieBattleground::Api::ValidationHelper
      include ZombieBattleground::Api::ResponseHelper

      attr_reader :total, :page, :limit, :cards

      validate :total_is_a_non_negative_integer
      validate :page_is_a_non_negative_integer
      validate :limit_is_a_non_negative_integer
      validate :cards_is_an_array_of_card

      def initialize(response)
        handle_errors(response)

        JSON.parse(response.body).each do |key, value|
          if key == 'cards'
            instance_variable_set("@#{key}".to_sym, value.map { |card| ZombieBattleground::Api::Card.new(card) })
          else
            instance_variable_set("@#{key}".to_sym, value)
          end
        end
      end

      def cards_is_an_array_of_card
        unless @cards.is_a?(Array)
          errors.add(:cards, 'Cards must be an array')
          return
        end

        @cards.each do |card|
          next if card.is_a?(ZombieBattleground::Api::Card) &&
                  card.valid? &&
                  card.errors.size.zero?

          errors.add(:cards, 'cards must be an array of Card')
        end
      end
    end
  end
end
