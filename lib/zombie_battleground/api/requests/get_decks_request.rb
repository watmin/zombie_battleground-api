# frozen_string_literal: true

require 'active_record'

require 'zombie_battleground/api/validation_helper'
require 'zombie_battleground/api/requests/request_helper'

module ZombieBattleground
  class Api
    class Requests
      ##
      # Request validator for GetDecks
      class GetDecksRequest
        include ActiveModel::Validations
        include ZombieBattleground::Api::ValidationHelper
        include ZombieBattleground::Api::Requests::RequestHelper

        # @!attribute [r] id
        # Optionally set the Deck's id for filtered querying
        #
        # @return [Integer]
        #
        # @example
        #   request.id #=> 1
        #
        # @api public
        attr_accessor :id

        # @!attribute [r] user_id
        # Optionally set the Deck's user_id for filtered querying
        #
        # @return [String]
        #
        # @example
        #   request.user_id #=> "ZombieSlayer_5699"
        #
        # @api public
        attr_accessor :user_id

        # @!attribute [r] deck_id
        # Optionally set the Deck's deck_id for filtered querying
        #
        # @return [Integer]
        #
        # @example
        #   request.deck_id #=> 1
        #
        # @api public
        attr_accessor :deck_id

        # @!attribute [r] name
        # Optionally set the Deck's name for filtered querying
        #
        # @return [String]
        #
        # @example
        #   request.name #=> "Buzzkill"
        #
        # @api public
        attr_accessor :name

        # @!attribute [r] hero_id
        # Optionally set the Deck's hero_id for filtered querying
        #
        # @return [Integer]
        #
        # @example
        #   request.hero_id #=> 1
        #
        # @api public
        attr_accessor :hero_id

        # @!attribute [r] primary_skill_id
        # Optionally set the Deck's primary_skill_id for filtered querying
        #
        # @return [Integer]
        #
        # @example
        #   request.primary_skill_id #=> 1
        #
        # @api public
        attr_accessor :primary_skill_id

        # @!attribute [r] secondary_skill_id
        # Optionally set the Deck's secondary_skill_id for filtered querying
        #
        # @return [Integer]
        #
        # @example
        #   request.secondary_skill_id #=> 1
        #
        # @api public
        attr_accessor :secondary_skill_id

        # @!attribute [r] version
        # Optionally set the Deck's version for filtered querying
        #
        # @return [String]
        #
        # @example
        #   request.version #=> "v3"
        #
        # @api public
        attr_accessor :version

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
        validate :user_id_is_a_string
        validate :deck_id_is_a_non_negative_integer
        validate :name_is_a_string
        validate :hero_id_is_a_non_negative_integer
        validate :primary_skill_id_is_a_non_negative_integer
        validate :secondary_skill_id_is_a_non_negative_integer
        validate :version_is_a_string
        validate :page_is_a_non_negative_integer
        validate :limit_is_a_non_negative_integer

        ##
        # The URI for the endpoint
        #
        # @return [String]
        #
        # @example
        #   request.uri # => "decks"
        #
        # @api public
        def uri
          'decks'
        end
      end
    end
  end
end
