# frozen_string_literal: true

require 'zombie_battleground/api/constants'

module ZombieBattleground
  class Api
    ##
    #  API Extensions
    module Extensions
      ##
      # API Extensions for Cards
      module Cards
        ##
        # Fetches all available cards
        #
        # @return [Array<ZombieBattleground::Api::Models::Card>]
        #
        # @example
        #   cards = ZombieBattleground::Api.all_cards
        #   # => [ZombieBattleground::Api::Models::Card]
        #
        # @api public
        def all_cards(**args)
          page = 1
          cards = []

          loop do
            response = @client.cards_request(args.merge(page: page))
            cards.push(*response.cards)
            break if response.cards.size < PAGE_MAX
            # :nocov:
            page += 1
            # :nocov:
          end

          cards
        end

        ##
        # Fetches all available cards
        #
        # @return [Array<ZombieBattleground::Api::Models::Card>]
        #
        # @example
        #   cards = ZombieBattleground::Api.all_cards
        #   # => [ZombieBattleground::Api::Models::Card]
        #
        # @api public
        def card_kinds
          all_cards.map(&:kind).uniq
        end

        ##
        # Fetches all card ranks
        #
        # @return [Array<String>]
        #
        # @example
        #   ranks = ZombieBattleground::Api.card_ranks
        #   # => [String]
        #
        # @api public
        def card_ranks
          all_cards.map(&:rank).uniq
        end

        ##
        # Fetches all card sets
        #
        # @return [Array<String>]
        #
        # @example
        #   sets = ZombieBattleground::Api.card_sets
        #   # => [String]
        #
        # @api public
        def card_sets
          all_cards.map(&:set).uniq
        end

        ##
        # Fetches all card types
        #
        # @return [Array<String>]
        #
        # @example
        #   types = ZombieBattleground::Api.card_types
        #   # => [String]
        #
        # @api public
        def card_types
          all_cards.map(&:type).uniq
        end

        ##
        # Fetches all card rarities
        #
        # @return [Array<String>]
        #
        # @example
        #   rarities = ZombieBattleground::Api.card_rarities
        #   # => [String]
        #
        # @api public
        def card_rarities
          all_cards.map(&:rarity).uniq
        end

        ##
        # Fetches all cards with selected kind
        #
        # @param kind [String]
        #
        # @return [Array<ZombieBattleground::Api::Models::Card>]
        #
        # @example
        #   cards = ZombieBattleground::Api.cards_by_kind(kind: "SPELL")
        #   # => [ZombieBattleground::Api::Models::Card]
        #
        # @api public
        def cards_by_kind(kind:)
          all_cards(kind: kind)
        end

        ##
        # Fetches all cards with selected rank
        #
        # @param rank [String]
        #
        # @return [Array<ZombieBattleground::Api::Models::Card>]
        #
        # @example
        #   cards = ZombieBattleground::Api.cards_by_rank(rank: "COMMANDER")
        #   # => [ZombieBattleground::Api::Models::Card]
        #
        # @api public
        def cards_by_rank(rank:)
          all_cards(rank: rank)
        end

        ##
        # Fetches all cards with selected set
        #
        # @param set [String]
        #
        # @return [Array<ZombieBattleground::Api::Models::Card>]
        #
        # @example
        #   cards = ZombieBattleground::Api.cards_by_set(set: "WATER")
        #   # => [ZombieBattleground::Api::Models::Card]
        #
        # @api public
        def cards_by_set(set:)
          all_cards(set: set)
        end

        ##
        # Fetches all cards with selected type
        #
        # @param type [String]
        #
        # @return [Array<ZombieBattleground::Api::Models::Card>]
        #
        # @example
        #   cards = ZombieBattleground::Api.cards_by_type(type: "WALKER")
        #   # => [ZombieBattleground::Api::Models::Card]
        #
        # @api public
        def cards_by_type(type:)
          all_cards(type: type)
        end

        ##
        # Fetches all cards with selected rarity
        #
        # @param rarity [String]
        #
        # @return [Array<ZombieBattleground::Api::Models::Card>]
        #
        # @example
        #   cards = ZombieBattleground::Api.cards_by_rarity(rarity: "")
        #   # => [ZombieBattleground::Api::Models::Card]
        #
        # @api public
        def cards_by_rarity(rarity:)
          all_cards(rarity: rarity)
        end
      end
    end
  end
end
