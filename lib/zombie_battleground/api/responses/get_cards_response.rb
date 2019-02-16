# frozen_string_literal: true

require 'active_record'
require 'json'

require 'zombie_battleground/api/models/card'
require 'zombie_battleground/api/validation_helper'
require 'zombie_battleground/api/responses/response_helper'

module ZombieBattleground
  class Api
    class Responses
      ##
      # Response validator for GetCards
      class GetCardsResponse
        include ActiveModel::Validations
        include ZombieBattleground::Api::ValidationHelper
        include ZombieBattleground::Api::Responses::ResponseHelper

        ##
        # @!attribute [r] total
        # the total number of results available
        #
        # @return [Integer]
        #
        # @example
        #   response.total #=> 1505
        #
        # @api public
        attr_reader :total

        ##
        # @!attribute [r] page
        # the page number of the results
        #
        # @return [Integer]
        #
        # @example
        #   response.page #=> 1
        #
        # @api public
        attr_reader :page

        ##
        # @!attribute [r] limit
        # the limit of results for the page
        #
        # @return [Integer]
        #
        # @example
        #   response.limit #=> 100
        #
        # @api public
        attr_reader :limit

        ##
        # @!attribute [r] cards
        # the deck found for the page and limit
        #
        # @return [Array<ZombieBattleground::Api::Models::Card>]
        #
        # @example
        #   response.deck #=> [ZombieBattleground::Api::Models::Card]
        #
        # @api public
        attr_reader :cards

        ##
        # @!attribute [a] remove_invalid
        # flag to remove objects in response that are invalid during validation
        #
        # @return [Boolean]
        #
        # @example
        #   response.remove_invalid = true
        #
        # @api public
        attr_accessor :remove_invalid

        validate :total_is_a_non_negative_integer
        validate :page_is_a_non_negative_integer
        validate :limit_is_a_non_negative_integer
        validate :cards_is_an_array_of_card

        ##
        # Creates a new GetCardsResponse
        #
        # @param response [Faraday::Response] Faraday response from endpoint
        #
        # @return [ZombieBattleground::Api::GetCardsResponse]
        #
        # @example
        #   response = ZombieBattleground::Api::GetCardsResponse.new(faraday_response)
        #   # => ZombieBattleground::Api::GetCardsResponse
        #
        # @api public
        def initialize(response)
          handle_errors(response)

          JSON.parse(response.body).each do |key, value|
            if key == 'cards'
              instance_variable_set(
                "@#{key}".to_sym, value.map { |card| ZombieBattleground::Api::Models::Card.new(card) }
              )
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
        def cards_is_an_array_of_card
          unless @cards.is_a?(Array)
            errors.add(:cards, 'Cards must be an array')
            return
          end

          if remove_invalid
            remove_invalid_cards
          else
            cards_contains_valid_cards
          end
        end

        ##
        # Validator for cards in cards
        #
        # @return [void]
        #
        # @api private
        def cards_contains_valid_cards
          @cards.each do |card|
            next if card.is_a?(ZombieBattleground::Api::Models::Card) &&
                    card.valid? &&
                    card.errors.size.zero?

            errors.add(:cards, 'cards must be an array of Card')
          end
        end

        ##
        # Removes invalid vards from card
        #
        # @return [void]
        #
        # @api private
        def remove_invalid_cards
          @cards.select! do |card|
            card.is_a?(ZombieBattleground::Api::Models::Card) &&
              card.valid? &&
              card.errors.size.zero?
          end
        end
      end
    end
  end
end
