# frozen_string_literal: true

require 'active_record'
require 'json'

require 'zombie_battleground/api/models/deck'
require 'zombie_battleground/api/validation_helper'
require 'zombie_battleground/api/responses/response_helper'

module ZombieBattleground
  class Api
    ##
    # Response validator for GetDecks
    class GetDecksResponse
      include ActiveModel::Validations
      include ZombieBattleground::Api::ValidationHelper
      include ZombieBattleground::Api::ResponseHelper

      attr_reader :total, :page, :limit, :decks

      validate :total_is_a_non_negative_integer
      validate :page_is_a_non_negative_integer
      validate :limit_is_a_non_negative_integer
      validate :decks_is_an_array_of_deck

      def initialize(response)
        handle_errors(response)

        JSON.parse(response.body).each do |key, value|
          if key == 'decks'
            instance_variable_set("@#{key}".to_sym, value.map { |deck| ZombieBattleground::Api::Deck.new(deck) })
          else
            instance_variable_set("@#{key}".to_sym, value)
          end
        end
      end

      def decks_is_an_array_of_deck
        unless @decks.is_a?(Array)
          errors.add(:decks, 'Decks must be an array')
          return
        end

        @decks.each do |deck|
          next if deck.is_a?(ZombieBattleground::Api::Deck) &&
                  deck.valid? &&
                  deck.errors.size.zero?

          errors.add(:decks, 'decks must be an array of Deck')
        end
      end
    end
  end
end
