# frozen_string_literal: true

require 'zombie_battleground/api/constants'

module ZombieBattleground
  class Api
    module Extensions
      ##
      # API Extensions for Cards
      module Cards
        ##
        # Returns an enumerator for all available cards, accepts a block for yields
        #
        # @return [Enumerator]
        #
        # @example Get an enumerator for the cards
        #   ZombieBattleground::Api.all_cards
        #   # => Enumerator
        #
        # @example Dump all cards as an array
        #   ZombieBattleground::Api.all_cards.to_a
        #   # => [ZombieBattleground::Api::Models::Card]
        #
        # @example Return the first card
        #   ZombieBattleground::Api.all_cards.first
        #   # => ZombieBattleground::Api::Models::Card
        #
        # @example Pass it a block
        #   ZombieBattleground::Api.all_cards do |card|
        #     do_something_with(card) if card.mould_id == "1" && card.version == "v3"
        #   end
        #   # => nil
        #
        # @api public
        def all_cards(**args)
          args.delete(:limit) # query as many as possible
          return enum_for(:all_cards) unless block_given?

          page = 1

          loop do
            response = @client.cards_request(args.merge(page: page))
            response.cards.each { |card| yield card }

            break if response.cards.size < PAGE_MAX
            # :nocov:
            page += 1
            # :nocov:
          end
        end

        ##
        # Fetches all card kinds
        #
        # @return [Array<String>]
        #
        # @example
        #   cards = ZombieBattleground::Api.card_kinds
        #   # => [String]
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
          all_cards(kind: kind).to_a
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
          all_cards(rank: rank).to_a
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
          all_cards(set: set).to_a
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
          all_cards(type: type).to_a
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
          all_cards(rarity: rarity).to_a
        end
      end
    end
  end
end
