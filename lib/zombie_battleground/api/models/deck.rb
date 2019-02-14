# frozen_string_literal: true

require 'active_record'

require 'zombie_battleground/api/validation_helper'
require 'zombie_battleground/api/models/simple_card'

module ZombieBattleground
  class Api
    class Models
      ##
      # Validator for Deck
      class Deck
        include ActiveModel::Validations
        include ZombieBattleground::Api::ValidationHelper

        ##
        # @!attribute [r] id
        # Deck's id
        #
        # @return [Integer]
        #
        # @example
        #   deck.id #=> 1812
        #
        # @api public
        attr_reader :id

        ##
        # @!attribute [r] created_at
        # the Deck's created_at time
        #
        # @return [Time]
        #
        # @example
        #   deck.created_at #=> Time
        #
        # @api public
        attr_reader :created_at

        ##
        # @!attribute [r] updated_at
        # the Deck's updated_at time
        #
        # @return [Time]
        #
        # @example
        #   deck.updated_at #=> Time
        #
        # @api public
        attr_reader :updated_at

        ##
        # @!attribute [r] user_id
        # the Deck's user_id
        #
        # @return [String]
        #
        # @example
        #   deck.user_id #=> "ZombieSlayer_5773"
        #
        # @api public
        attr_reader :user_id

        ##
        # @!attribute [r] deck_id
        # the Deck's deck_id
        #
        # @return [Integer]
        #
        # @example
        #   deck.deck_id #=> 4
        #
        # @api public
        attr_reader :deck_id

        ##
        # @!attribute [r] name
        # the Deck's name
        #
        # @return [String]
        #
        # @example
        #   deck.name #=> "Leaf Midrange"
        #
        # @api public
        attr_reader :name

        ##
        # @!attribute [r] hero_id
        # the Deck's hero_id
        #
        # @return [Integer]
        #
        # @example
        #   deck.hero_id #=> 5
        #
        # @api public
        attr_reader :hero_id

        ##
        # @!attribute [r] cards
        # the Deck's cards
        #
        # @return [Array<ZombieBattleground::Api::Models::SimpleCard>]
        #
        # @example
        #   deck.cards #=> [ZombieBattleground::Api::Models::SimpleCard]
        #
        # @api public
        attr_reader :cards

        ##
        # @!attribute [r] primary_skill_id
        # the Deck's primary_skill_id
        #
        # @return [Integer]
        #
        # @example
        #   deck.primary_skill_id #=> 19
        #
        # @api public
        attr_reader :primary_skill_id

        ##
        # @!attribute [r] secondary_skill_id
        # the Deck's secondary_skill_id
        #
        # @return [Integer]
        #
        # @example
        #   deck.secondary_skill_id #=> 18
        #
        # @api public
        attr_reader :secondary_skill_id

        ##
        # @!attribute [r] version
        # the Deck's version
        #
        # @return [String]
        #
        # @example
        #   deck.version #=> "v5"
        #
        # @api public
        attr_reader :version

        ##
        # @!attribute [r] sender_address
        # the Deck's sender_address
        #
        # @return [String]
        #
        # @example
        #   deck.sender_address #=> "0x62bb8C4452c3Fa7E9eEd6D9Ceaa4d3fe8E18E249"
        #
        # @api public
        attr_reader :sender_address

        ##
        # @!attribute [r] block_height
        # the Deck's block_height
        #
        # @return [Integer]
        #
        # @example
        #   deck.block_height #=> 939237
        #
        # @api public
        attr_reader :block_height

        ##
        # @!attribute [r] is_deleted
        # the Deck's is_deleted
        #
        # @return [Boolean]
        #
        # @example
        #   deck.is_deleted #=> false
        #
        # @api public
        attr_reader :is_deleted

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

        ##
        # Creates a new Deck
        #
        # @param card [Hash] Parsed JSON response
        #
        # @return [ZombieBattleground::Api::Deck]
        #
        # @example
        #   deck = ZombieBattleground::Api::Deck.new(parsed_json)
        #   # => ZombieBattleground::Api::Deck
        #
        # @api public
        def initialize(deck)
          deck.each do |key, value|
            next if value.nil? # this is an illegal response, deck id 1 is bogus

            if key == 'cards'
              instance_variable_set(
                "@#{key}".to_sym, value.map { |card| ZombieBattleground::Api::Models::SimpleCard.new(card) }
              )
            elsif %w[created_at updated_at].include?(key)
              instance_variable_set("@#{key}".to_sym, Time.parse(value))
            else
              instance_variable_set("@#{key}".to_sym, value)
            end
          end
        end

        private

        ##
        # Validator for cards attribute
        #
        # @return [void]
        #
        # @api private
        def cards_is_an_array_of_simple_card
          unless @cards.is_a?(Array)
            errors.add(:cards, 'cards must be an Array')
            return
          end

          @cards.each do |card|
            next if card.is_a?(ZombieBattleground::Api::Models::SimpleCard) &&
                    card.valid? &&
                    card.errors.size.zero?

            errors.add(:cards, 'cards must be an array of SimpleCard')
          end
        end
      end
    end
  end
end
