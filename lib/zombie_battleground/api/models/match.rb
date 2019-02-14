# frozen_string_literal: true

require 'active_record'

require 'zombie_battleground/api/validation_helper'

module ZombieBattleground
  class Api
    ##
    # Validator for Match
    class Match
      include ActiveModel::Validations
      include ZombieBattleground::Api::ValidationHelper

      attr_reader :id, :created_at, :updated_at, :player1_id, :player2_id, :player1_accepted,
                  :player2_accepted, :player1_deck_id, :player2_deck_id, :status, :version,
                  :random_seed, :winner_id, :block_height

      validate :id_is_a_non_negative_integer
      validate :created_at_is_a_time_and_not_null
      validate :updated_at_is_a_time_and_not_null
      validate :player1_id_is_a_string_and_not_null
      validate :player2_id_is_a_string_and_not_null
      validates :player1_accepted, inclusion: { in: [true, false] }
      validates :player2_accepted, inclusion: { in: [true, false] }
      validate :player1_deck_id_is_a_non_negative_integer
      validate :player2_deck_id_is_a_non_negative_integer
      validate :status_is_a_string_and_not_null
      validate :version_is_a_string_and_not_null
      validate :random_seed_is_a_non_negative_integer
      validate :winner_id_is_a_string_and_not_null
      validate :block_height_is_a_non_negative_integer_and_not_null

      def initialize(match)
        match.each do |key, value|
          next if value.nil? # this is an illegal response, match id 1 is bogus

          if %w[created_at updated_at].include?(key)
            instance_variable_set("@#{key}".to_sym, Time.parse(value))
          else
            instance_variable_set("@#{key}".to_sym, value)
          end
        end
      end
    end
  end
end
