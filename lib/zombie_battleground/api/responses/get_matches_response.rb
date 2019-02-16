# frozen_string_literal: true

require 'active_record'
require 'json'

require 'zombie_battleground/api/models/match'
require 'zombie_battleground/api/validation_helper'
require 'zombie_battleground/api/responses/response_helper'

module ZombieBattleground
  class Api
    class Responses
      ##
      # Response validator for GetMatches
      class GetMatchesResponse
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
        # @!attribute [r] matches
        # the matches found for the page and limit
        #
        # @return [Array<ZombieBattleground::Api::Models::Match>]
        #
        # @example
        #   response.matches #=> [ZombieBattleground::Api::Models::Match]
        #
        # @api public
        attr_reader :matches

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
        validate :matches_is_an_array_of_match

        ##
        # Creates a new GetMatchesResponse
        #
        # @param response [Faraday::Response] Faraday response from endpoint
        #
        # @return [ZombieBattleground::Api::GetMatchesResponse]
        #
        # @example
        #   response = ZombieBattleground::Api::GetMatchesResponse.new(faraday_response)
        #   # => ZombieBattleground::Api::GetMatchesResponse
        #
        # @api public
        def initialize(response)
          handle_errors(response)

          JSON.parse(response.body).each do |key, value|
            if key == 'matches'
              instance_variable_set(
                "@#{key}".to_sym, value.map { |match| ZombieBattleground::Api::Models::Match.new(match) }
              )
            else
              instance_variable_set("@#{key}".to_sym, value)
            end
          end
        end

        private

        ##
        # Validator for matches attribute
        #
        # @return [void]
        #
        # @api private
        def matches_is_an_array_of_match
          unless @matches.is_a?(Array)
            errors.add(:matches, 'Matchs must be an array')
            return
          end

          if remove_invalid
            remove_invalid_matches
          else
            matches_contains_valid_matches
          end
        end

        ##
        # Validator for matches in matches
        #
        # @return [void]
        #
        # @api private
        def matches_contains_valid_matches
          @matches.each do |match|
            next if match.is_a?(ZombieBattleground::Api::Models::Match) &&
                    match.valid? &&
                    match.errors.size.zero?

            errors.add(:matches, 'matches must be an array of Match')
          end
        end

        ##
        # Removes invalid vards from match
        #
        # @return [void]
        #
        # @api private
        def remove_invalid_matches
          @matches.select! do |match|
            match.is_a?(ZombieBattleground::Api::Models::Match) &&
              match.valid? &&
              match.errors.size.zero?
          end
        end
      end
    end
  end
end
