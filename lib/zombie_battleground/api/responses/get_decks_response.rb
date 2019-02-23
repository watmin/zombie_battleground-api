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
        #   response.decks #=> [ZombieBattleground::Api::Models::Deck]
        #
        # @api public
        attr_reader :decks

        ##
        # @!attribute [r] decks_count
        # the number of decks returned in the response
        #
        # @return [Integer]
        #
        # @example
        #   response.decks_count #=> 1
        #
        # @api public
        attr_reader :decks_count

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
              # Keep the API response count, it will differ when invalid decks are stripped
              @decks_count = value.size

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

          if remove_invalid
            remove_invalid_decks
          else
            decks_contains_valid_decks
          end
        end

        ##
        # Validator for decks in decks
        #
        # @return [void]
        #
        # @api private
        def decks_contains_valid_decks
          @decks.each do |deck|
            next if deck.is_a?(ZombieBattleground::Api::Models::Deck) &&
                    deck.valid? &&
                    deck.errors.size.zero?

            errors.add(:decks, 'decks must be an array of Deck')
          end
        end

        ##
        # Removes invalid vards from deck
        #
        # @return [void]
        #
        # @api private
        def remove_invalid_decks
          @decks.select! do |deck|
            deck.is_a?(ZombieBattleground::Api::Models::Deck) &&
              deck.valid? &&
              deck.errors.size.zero?
          end
        end
      end
    end
  end
end
