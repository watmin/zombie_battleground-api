# frozen_string_literal: true

require 'active_record'

require 'zombie_battleground/api/validation_helper'
require 'zombie_battleground/api/requests/request_helper'

module ZombieBattleground
  class Api
    class Requests
      ##
      # Request validator for GetMatches
      class GetMatchesRequest
        include ActiveModel::Validations
        include ZombieBattleground::Api::ValidationHelper
        include ZombieBattleground::Api::Requests::RequestHelper

        ##
        # @!attribute [r] id
        # Optionally set the Match's id for filtered querying
        #
        # @return [Integer]
        #
        # @example
        #   request.id #=> 1
        #
        # @api public
        attr_accessor :id

        ##
        # @!attribute [r] player1_id
        # Optionally set the Match's player1_id for filtered querying
        #
        # @return [String]
        #
        # @example
        #   request.player1_id #=> "ZombieSlayer_16601021609396167139295300949176"
        #
        # @api public
        attr_accessor :player1_id

        ##
        # @!attribute [r] player2_id
        # Optionally set the Match's player2_id for filtered querying
        #
        # @return [String]
        #
        # @example
        #   request.player2_id #=> "ZombieSlayer_16601021609396167139295300949176"
        #
        # @api public
        attr_accessor :player2_id

        ##
        # @!attribute [r] status
        # Optionally set the Match's status for filtered querying
        #
        # @return [String]
        #
        # @example
        #   request.status #=> "Ended"
        #
        # @api public
        attr_accessor :status

        ##
        # @!attribute [r] version
        # Optionally set the Match's version for filtered querying
        #
        # @return [String]
        #
        # @example
        #   request.version #=> "v3"
        #
        # @api public
        attr_accessor :version

        ##
        # @!attribute [r] winner_id
        # Optionally set the Match's winner_id for filtered querying
        #
        # @return [String]
        #
        # @example
        #   request.winner_id #=> "ZombieSlayer_16601021609396167139295300949176"
        #
        # @api public
        attr_accessor :winner_id

        ##
        # @!attribute [r] page
        # Optionally set the page number for filtered querying
        #
        # @return [Integer]
        #
        # @example
        #   request.page #=> 1
        #
        # @api public
        attr_accessor :page

        ##
        # @!attribute [r] limit
        # Optionally set the limit for max Matches returned
        #
        # @return [Integer]
        #
        # @example
        #   request.limit #=> 100
        #
        # @api public
        attr_accessor :limit

        validate :id_is_a_non_negative_integer
        validate :player1_id_is_a_string
        validate :player2_id_is_a_string
        validate :status_is_a_string
        validate :version_is_a_string
        validate :winner_id_is_a_string
        validate :page_is_a_non_negative_integer
        validate :limit_is_a_non_negative_integer

        ##
        # The URI for the endpoint
        #
        # @return [String]
        #
        # @example
        #   request.uri # => "matches"
        #
        # @api public
        def uri
          'matches'
        end
      end
    end
  end
end
