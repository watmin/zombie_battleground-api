# frozen_string_literal: true

require 'active_record'

require 'zombie_battleground/api/validation_helper'

module ZombieBattleground
  class Api
    class Models
      ##
      # Validator for SimpleCard (only returned from GetDeck(s))
      class SimpleCard
        include ActiveModel::Validations
        include ZombieBattleground::Api::ValidationHelper

        ##
        # @!attribute [r] card_name
        # the Card's name
        #
        # @return [String]
        #
        # @example
        #   simple_card.card_name #=> "Hazmaz"
        #
        # @api public
        attr_reader :card_name

        ##
        # @!attribute [r] amount
        # the amount of the Card in the deck
        #
        # @return [Integer]
        #
        # @example
        #   simple_card.amount #=> 2
        #
        # @api public
        attr_reader :amount

        validate :card_name_is_a_string_and_not_null
        validate :amount_is_a_non_negative_integer_and_not_null

        ##
        # Creates a new SimpleCard (returned by GetDeck(s))
        #
        # @param card [Hash] Parsed JSON response
        #
        # @return [ZombieBattleground::Api::SimpleCard]
        #
        # @example
        #   simple_card = ZombieBattleground::Api::SimpleCard.new(parsed_json)
        #   # => ZombieBattleground::Api::SimpleCard
        #
        # @api public
        def initialize(card)
          card.each do |key, value|
            instance_variable_set("@#{key}".to_sym, value)
          end
        end
      end
    end
  end
end
