# frozen_string_literal: true

require 'active_record'

require 'zombie_battleground/api/validation_helper'

module ZombieBattleground
  class Api
    ##
    # Namespace for Models
    class Models
      ##
      # Validator for Card
      class Card
        include ActiveModel::Validations
        include ZombieBattleground::Api::ValidationHelper

        ##
        # @!attribute [r] id
        # the Cards's id
        #
        # @return [Integer]
        #
        # @example
        #   card.id #=> 1
        #
        # @api public
        attr_reader :id

        ##
        # @!attribute [r] mould_id
        # the Cards's mould_id
        #
        # @return [String]
        #
        # @example
        #   card.mould_id #=> "1"
        #
        # @api public
        attr_reader :mould_id

        ##
        # @!attribute [r] version
        # the Cards's version
        #
        # @return [String]
        #
        # @example
        #   card.version #=> "v3"
        #
        # @api public
        attr_reader :version

        ##
        # @!attribute [r] kind
        # the Cards's kind
        #
        # @return [String]
        #
        # @example
        #   card.kind #=> "CREATURE"
        #
        # @api public
        attr_reader :kind

        ##
        # @!attribute [r] set
        # the Cards's set
        #
        # @return [String]
        #
        # @example
        #   card.set #=> "AIR"
        #
        # @api public
        attr_reader :set

        ##
        # @!attribute [r] name
        # the Cards's name
        #
        # @return [String]
        #
        # @example
        #   card.name #=> "Whizpar"
        #
        # @api public
        attr_reader :name

        ##
        # @!attribute [r] description
        # the Cards's description
        #
        # @return [String]
        #
        # @example
        #   card.description #=> "<b>Attack:</b> +1 damage to Water zombies"
        #
        # @api public
        attr_reader :description

        ##
        # @!attribute [r] flavor_text
        # the Cards's flavor_text
        #
        # @return [String]
        #
        # @example
        #   card.flavor_text #=> "The unfriendly ghost..."
        #
        # @api public
        attr_reader :flavor_text

        ##
        # @!attribute [r] picture
        # the Cards's picture
        #
        # @return [String]
        #
        # @example
        #   card.picture #=> "Whizpar"
        #
        # @api public
        attr_reader :picture

        ##
        # @!attribute [r] rank
        # the Cards's rank
        #
        # @return [String]
        #
        # @example
        #   card.rank #=> "MINION"
        #
        # @api public
        attr_reader :rank

        ##
        # @!attribute [r] type
        # the Cards's type
        #
        # @return [String]
        #
        # @example
        #   card.type #=> "WALKER"
        #
        # @api public
        attr_reader :type

        ##
        # @!attribute [r] rarity
        # the Cards's rarity
        #
        # @return [String]
        #
        # @example
        #   card.rarity #=> ""
        #
        # @api public
        attr_reader :rarity

        ##
        # @!attribute [r] frame
        # the Cards's frame
        #
        # @return [String]
        #
        # @example
        #   card.frame #=> ""
        #
        # @api public
        attr_reader :frame

        ##
        # @!attribute [r] damage
        # the Cards's damage
        #
        # @return [Integer]
        #
        # @example
        #   card.damage #=> 1
        #
        # @api public
        attr_reader :damage

        ##
        # @!attribute [r] health
        # the Cards's health
        #
        # @return [Integer]
        #
        # @example
        #   card.health #=> 1
        #
        # @api public
        attr_reader :health

        ##
        # @!attribute [r] cost
        # the Cards's cost
        #
        # @return [Integer]
        #
        # @example
        #   card.cost #=> 1
        #
        # @api public
        attr_reader :cost

        ##
        # @!attribute [r] ability
        # the Cards's ability
        #
        # @return [String]
        #
        # @example
        #   card.ability #=> ""
        #
        # @api public
        attr_reader :ability

        ##
        # @!attribute [r] block_height
        # the Cards's block_height
        #
        # @return [Integer]
        #
        # @example
        #   card.block_height #=> 0
        #
        # @api public
        attr_reader :block_height

        ##
        # @!attribute [r] image_url
        # the Cards's image_url
        #
        # @return [String]
        #
        # @example
        #   card.image_url #=> "https://loom.games/img/cards/001.png"
        #
        # @api public
        attr_reader :image_url

        validate :id_is_a_non_negative_integer
        validate :mould_id_is_a_string_and_not_null
        validate :version_is_a_string_and_not_null
        validate :kind_is_a_string_and_not_null
        validate :set_is_a_string_and_not_null
        validate :name_is_a_string_and_not_null
        validate :description_is_a_string_and_not_null
        validate :rank_is_a_string_and_not_null
        validate :type_is_a_string_and_not_null
        validate :rarity_is_a_string_and_not_null
        validate :frame_is_a_string_and_not_null
        validate :damage_is_a_non_negative_integer_and_not_null
        validate :health_is_a_non_negative_integer_and_not_null
        validate :cost_is_a_non_negative_integer_and_not_null
        validate :ability_is_a_string_and_not_null
        validate :block_height_is_a_non_negative_integer_and_not_null
        validate :image_url_is_a_string_and_not_null

        ##
        # Creates a new Card
        #
        # @param card [Hash] Parsed JSON response
        #
        # @return [ZombieBattleground::Api::Card]
        #
        # @example
        #   card = ZombieBattleground::Api::Card.new(parsed_json)
        #   # => ZombieBattleground::Api::Card
        #
        # @api public
        def initialize(card)
          card.each do |key, value|
            next if value.nil? # this is an illegal response, card id 1 is bogus

            instance_variable_set("@#{key}".to_sym, value)
          end
        end
      end
    end
  end
end
