# frozen_string_literal: true

require 'active_record'

require 'zombie_battleground/api/validation_helper'
require 'zombie_battleground/api/models/simple_card'

module ZombieBattleground
  class Api
    ##
    # Validator for Deck
    class Deck
      include ActiveModel::Validations
      include ZombieBattleground::Api::ValidationHelper

      attr_reader :id, :created_at, :updated_at, :user_id, :deck_id, :name, :hero_id,
                  :cards, :primary_skill_id, :secondary_skill_id, :version, :sender_address,
                  :block_height, :is_deleted

      validate :id_is_a_non_negative_integer
      validate :created_at_is_a_time_and_not_null
      validate :updated_at_is_a_time_and_not_null
      validate :user_id_is_a_string_and_not_null
      validate :deck_id_is_a_non_negative_integer_and_not_null
      validate :name_is_a_string_and_not_null
      validate :hero_id_is_a_non_negative_integer_and_not_null
      validate :cards_is_an_array_of_simple_card
      validate :primary_skill_id_is_a_non_negative_integer_and_not_null
      validate :secondary_skill_id_is_a_non_negative_integer_and_not_null
      validate :version_is_a_string_and_not_null
      validate :sender_address_is_a_string_and_not_null
      validate :block_height_is_a_non_negative_integer_and_not_null
      validates :is_deleted, inclusion: { in: [true, false] }

      def initialize(deck)
        deck.each do |key, value|
          next if value.nil? # this is an illegal response, deck id 1 is bogus

          if key == 'cards'
            instance_variable_set("@#{key}".to_sym, value.map { |card| ZombieBattleground::Api::SimpleCard.new(card) })
          elsif %w[created_at updated_at].include?(key)
            instance_variable_set("@#{key}".to_sym, Time.parse(value))
          else
            instance_variable_set("@#{key}".to_sym, value)
          end
        end
      end

      def cards_is_an_array_of_simple_card
        unless @cards.is_a?(Array)
          errors.add(:cards, 'cards must be an Array')
          return
        end

        @cards.each do |card|
          next if card.is_a?(ZombieBattleground::Api::SimpleCard) &&
                  card.valid? &&
                  card.errors.size.zero?

          errors.add(:cards, 'cards must be an array of SimpleCard')
        end
      end
    end
  end
end
