# frozen_string_literal: true

require 'active_record'

require 'zombie_battleground/api/validation_helper'

module ZombieBattleground
  class Api
    class Models
      ##
      # Validator for Match
      class Match
        include ActiveModel::Validations
        include ZombieBattleground::Api::ValidationHelper

        ##
        # @!attribute [r] id
        # the Match's id
        #
        # @return [Integer]
        #
        # @example
        #   match.id #=> 1
        #
        # @api public
        attr_reader :id

        ##
        # @!attribute [r] created_at
        # the Match's created_at time
        #
        # @return [Time]
        #
        # @example
        #   match.created_at #=> Time
        #
        # @api public
        attr_reader :created_at

        ##
        # @!attribute [r] updated_at
        # the Match's updated_at time
        #
        # @return [Time]
        #
        # @example
        #   match.updated_at #=> Time
        #
        # @api public
        attr_reader :updated_at

        ##
        # @!attribute [r] player1_id
        # the Match's player1_id
        #
        # @return [String]
        #
        # @example
        #   match.player1_id #=> "ZombieSlayer_16601"
        #
        # @api public
        attr_reader :player1_id

        ##
        # @!attribute [r] player2_id
        # the Match's player2_id
        #
        # @return [String]
        #
        # @example
        #   match.player2_id #=> "ZombieSlayer_50758"
        #
        # @api public
        attr_reader :player2_id

        ##
        # @!attribute [r] player1_accepted
        # the Match's player1_accepted
        #
        # @return [Boolean]
        #
        # @example
        #   match.player1_accepted #=> true
        #
        # @api public
        attr_reader :player1_accepted

        ##
        # @!attribute [r] player2_accepted
        # the Match's player2_accepted
        #
        # @return [Boolean]
        #
        # @example
        #   match.player2_accepted #=> true
        #
        # @api public
        attr_reader :player2_accepted

        ##
        # @!attribute [r] player1_deck_id
        # the Match's player1_deck_id
        #
        # @return [Integer]
        #
        # @example
        #   match.player1_deck_id #=> 1
        #
        # @api public
        attr_reader :player1_deck_id

        ##
        # @!attribute [r] player2_deck_id
        # the Match's player2_deck_id
        #
        # @return [Integer]
        #
        # @example
        #   match.player2_deck_id #=> 4
        #
        # @api public
        attr_reader :player2_deck_id

        ##
        # @!attribute [r] status
        # the Match's status
        #
        # @return [String]
        #
        # @example
        #   match.status #=> "Ended"
        #
        # @api public
        attr_reader :status

        ##
        # @!attribute [r] version
        # the Match's version
        #
        # @return [String]
        #
        # @example
        #   match.version #=> "v3"
        #
        # @api public
        attr_reader :version

        ##
        # @!attribute [r] random_seed
        # the Match's random_seed
        #
        # @return [Integer]
        #
        # @example
        #   match.random_seed #=> 1548242486
        #
        # @api public
        attr_reader :random_seed

        ##
        # @!attribute [r] winner_id
        # the Match's winner_id
        #
        # @return [String]
        #
        # @example
        #   match.winner_id #=> "ZombieSlayer_507586"
        #
        # @api public
        attr_reader :winner_id

        ##
        # @!attribute [r] block_height
        # the Match's block_height
        #
        # @return [Integer]
        #
        # @example
        #   match.block_height #=> 497513
        #
        # @api public
        attr_reader :block_height

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

        ##
        # Creates a new Match
        #
        # @param match [Hash] Parsed JSON response
        #
        # @return [ZombieBattleground::Api::Match]
        #
        # @example
        #   match = ZombieBattleground::Api::Match.new(parsed_json)
        #   # => ZombieBattleground::Api::Match
        #
        # @api public
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
end
