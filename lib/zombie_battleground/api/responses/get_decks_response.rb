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
      # Response validator for GetDecks
      class GetDecksResponse
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
        # @!attribute [r] decks
        # the deck found for the page and limit
        #
        # @return [Array<ZombieBattleground::Api::Models::Deck>]
        #
        # @example
        #   response.deck #=> [ZombieBattleground::Api::Models::Deck]
        #
        # @api public
        attr_reader :decks

        validate :total_is_a_non_negative_integer
        validate :page_is_a_non_negative_integer
        validate :limit_is_a_non_negative_integer
        validate :decks_is_an_array_of_deck

        ##
        # Creates a new GetDecksResponse
        #
        # @param response [Faraday::Response] Faraday response from endpoint
        #
        # @return [ZombieBattleground::Api::GetDecksResponse]
        #
        # @example
        #   response = ZombieBattleground::Api::GetDecksResponse.new(faraday_response)
        #   # => ZombieBattleground::Api::GetDecksResponse
        #
        # @api public
        def initialize(response)
          handle_errors(response)

          JSON.parse(response.body).each do |key, value|
            if key == 'decks'
              instance_variable_set(
                "@#{key}".to_sym, value.map { |deck| ZombieBattleground::Api::Models::Deck.new(deck) }
              )
            else
              instance_variable_set("@#{key}".to_sym, value)
            end
          end
        end

        private

        ##
        # Validator for decks attribute
        #
        # @return [void]
        #
        # @api private
        def decks_is_an_array_of_deck
          unless @decks.is_a?(Array)
            errors.add(:decks, 'Decks must be an array')
            return
          end

          @decks.each do |deck|
            next if deck.is_a?(ZombieBattleground::Api::Models::Deck) &&
                    deck.valid? &&
                    deck.errors.size.zero?

            errors.add(:decks, 'decks must be an array of Deck')
          end
        end
      end
    end
  end
end
