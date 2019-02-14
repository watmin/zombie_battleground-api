# frozen_string_literal: true

require 'active_record'

require 'zombie_battleground/api/validation_helper'
require 'zombie_battleground/api/requests/request_helper'

module ZombieBattleground
  class Api
    class Requests
      ##
      # Request validator for GetCards
      class GetCardsRequest
        include ActiveModel::Validations
        include ZombieBattleground::Api::ValidationHelper
        include ZombieBattleground::Api::Requests::RequestHelper

        ##
        # @!attribute [r] id
        # Optionally set the Card's id for filtered querying
        #
        # @return [Integer]
        #
        # @example
        #   request.id #=> 1
        #
        # @api public
        attr_accessor :id

        ##
        # @!attribute [r] mould_id
        # Optionally mould_id the Card's mould_id for filtered querying
        #
        # @return [String]
        #
        # @example
        #   request.mould_id #=> "1"
        #
        # @api public
        attr_accessor :mould_id

        ##
        # @!attribute [r] version
        # Optionally version the Card's version for filtered querying
        #
        # @return [String]
        #
        # @example
        #   request.version #=> "v3"
        #
        # @api public
        attr_accessor :version

        ##
        # @!attribute [r] set
        # Optionally set the Card's set for filtered querying
        #
        # @return [String]
        #
        # @example
        #   request.set #=> "AIR"
        #
        # @api public
        attr_accessor :kind

        ##
        # @!attribute [r] set
        # Optionally set the Card's set for filtered querying
        #
        # @return [String]
        #
        # @example
        #   request.set #=> "AIR"
        #
        # @api public
        attr_accessor :set

        ##
        # @!attribute [r] name
        # Optionally set the Card's name for filtered querying
        #
        # @return [String]
        #
        # @example
        #   request.name #=> "Whizpar"
        #
        # @api public
        attr_accessor :name

        ##
        # @!attribute [r] rank
        # Optionally set the Card's rank for filtered querying
        #
        # @return [String]
        #
        # @example
        #   request.rank #=> "MINION"
        #
        # @api public
        attr_accessor :rank

        ##
        # @!attribute [r] type
        # Optionally set the Card's type for filtered querying
        #
        # @return [String]
        #
        # @example
        #   request.type #=> "WALKER"
        #
        # @api public
        attr_accessor :type

        ##
        # @!attribute [r] rarity
        # Optionally set the Card's rarity for filtered querying
        #
        # @return [String]
        #
        # @example
        #   request.rarity #=> ""
        #
        # @api public
        attr_accessor :rarity

        ##
        # @!attribute [r] damage
        # Optionally set the Card's damage for filtered querying
        #
        # @return [Integer]
        #
        # @example
        #   request.damage #=> 1
        #
        # @api public
        attr_accessor :damage

        ##
        # @!attribute [r] health
        # Optionally set the Card's health for filtered querying
        #
        # @return [Integer]
        #
        # @example
        #   request.health #=> 1
        #
        # @api public
        attr_accessor :health

        ##
        # @!attribute [r] cost
        # Optionally set the Card's cost for filtered querying
        #
        # @return [Integer]
        #
        # @example
        #   request.cost #=> 1
        #
        # @api public
        attr_accessor :cost

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
        # Optionally set the limit for max Cards returned
        #
        # @return [Integer]
        #
        # @example
        #   request.limit #=> 100
        #
        # @api public
        attr_accessor :limit

        validate :id_is_a_non_negative_integer
        validate :mould_id_is_a_string
        validate :version_is_a_string
        validate :kind_is_a_string
        validate :set_is_a_string
        validate :name_is_a_string
        validate :rank_is_a_string
        validate :type_is_a_string
        validate :rarity_is_a_string
        validate :damage_is_a_non_negative_integer
        validate :health_is_a_non_negative_integer
        validate :cost_is_a_non_negative_integer
        validate :page_is_a_non_negative_integer
        validate :limit_is_a_non_negative_integer

        ##
        # The URI for the endpoint
        #
        # @return [String]
        #
        # @example
        #   request.uri # => "cards"
        #
        # @api public
        def uri
          'cards'
        end
      end
    end
  end
end
