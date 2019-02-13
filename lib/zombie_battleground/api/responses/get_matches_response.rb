# frozen_string_literal: true

require 'active_record'
require 'json'

require 'zombie_battleground/api/models/match'
require 'zombie_battleground/api/validation_helper'
require 'zombie_battleground/api/responses/response_helper'

module ZombieBattleground
  module Api
    ##
    # Response validator for GetMatches
    class GetMatchesResponse
      include ActiveModel::Validations
      include ZombieBattleground::Api::ValidationHelper
      include ZombieBattleground::Api::ResponseHelper

      attr_reader :total, :page, :limit, :matches

      validate :total_is_a_non_negative_integer
      validate :page_is_a_non_negative_integer
      validate :limit_is_a_non_negative_integer
      validate :matches_is_an_array_of_match

      def initialize(response)
        handle_errors(response)

        JSON.parse(response.body).each do |key, value|
          if key == 'matches'
            instance_variable_set("@#{key}".to_sym, value.map { |match| ZombieBattleground::Api::Match.new(match) })
          else
            instance_variable_set("@#{key}".to_sym, value)
          end
        end
      end

      def matches_is_an_array_of_match
        unless @matches.is_a?(Array)
          errors.add(:matches, 'Matchs must be an array')
          return
        end

        @matches.each do |match|
          next if match.is_a?(ZombieBattleground::Api::Match) &&
                  match.valid? &&
                  match.errors.size.zero?

          errors.add(:matches, 'matches must be an array of Match')
        end
      end
    end
  end
end
