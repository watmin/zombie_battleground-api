# frozen_string_literal: true

require 'zombie_battleground/api/client'
require 'zombie_battleground/api/extensions'

module ZombieBattleground
  ##
  # API for Zombie Battleground
  class Api
    @client = ZombieBattleground::Api::Client.new

    class << self
      include ZombieBattleground::Api::Extensions

      ##
      # Queries for Decks and returns a modeled response
      #
      # @param id [Integer] Optionally filter on Deck id
      # @param user_id [String] Optionally filter on Deck user_id
      # @param deck_id [Integer] Optionally filter on Deck deck_id
      # @param name [String] Optionally filter on Deck name
      # @param hero_id [Integer] Optionally filter on Deck hero_id
      # @param primary_skill_id [Integer] Optionally filter on Deck primary_skill_id
      # @param secondary_skill_id [Integer] Optionally filter on Deck secondary_skill_id
      # @param version [String] Optionally filter on Deck version
      # @param page [Integer] Used for pagination of query results
      # @param limit [Integer] Used for pagination of query results. Max 100
      #
      # @return [ZombieBattleground::Api::Responses::GetDecksResponse]
      #
      # @example
      #   response = ZombieBattleground::Api.decks_request(limit: 1)
      #   # => ZombieBattleground::Api::Responses::GetDecksResponse
      #
      # @api public
      def decks_request(**args)
        @client.decks_request(**args)
      end

      ##
      # Queries for Decks and returns the decks in the response
      #
      # @param id [Integer] Optionally filter on Deck id
      # @param user_id [String] Optionally filter on Deck user_id
      # @param deck_id [Integer] Optionally filter on Deck deck_id
      # @param name [String] Optionally filter on Deck name
      # @param hero_id [Integer] Optionally filter on Deck hero_id
      # @param primary_skill_id [Integer] Optionally filter on Deck primary_skill_id
      # @param secondary_skill_id [Integer] Optionally filter on Deck secondary_skill_id
      # @param version [String] Optionally filter on Deck version
      # @param page [Integer] Used for pagination of query results
      # @param limit [Integer] Used for pagination of query results. Max 100
      #
      # @return [Array<ZombieBattleground::Api::Models::Deck>]
      #
      # @example
      #   decks = ZombieBattleground::Api.decks(limit: 1)
      #   # => [ZombieBattleground::Api::Models::Deck]
      #
      # @api public
      def decks(**args)
        decks_request(**args).decks
      end

      ##
      # Queries for a Deck and returns the response
      #
      # @param id [Integer] Deck id to request
      #
      # @return [ZombieBattleground::Api::Responses::GetDeckResponse]
      #
      # @example
      #   response = ZombieBattleground::Api.deck_request(id: 1813)
      #   # => ZombieBattleground::Api::Responses::GetDeckResponse
      #
      # @api public
      def deck_request(**args)
        @client.deck_request(**args)
      end

      ##
      # Queries for a Deck and returns deck in the response
      #
      # @param id [Integer] Deck id to request
      #
      # @return [ZombieBattleground::Api::Models::Deck]
      #
      # @example
      #   deck = ZombieBattleground::Api.deck(id: 1813)
      #   # => ZombieBattleground::Api::Models::Deck
      #
      # @api public
      def deck(**args)
        deck_request(**args).deck
      end

      ##
      # Queries for Matches and returns the response
      #
      # @param id [Integer] Optionally filter on Match id
      # @param player1_id [String] Optionally filter on Match player1_id
      # @param player2_id [String] Optionally filter on Match player2_id
      # @param status [String] Optionally filter on Match status
      # @param version [String] Optionally filter on Match version
      # @param winner_id [String] Optionally filter on Match winner_id
      # @param page [Integer] Used for pagination of query results
      # @param limit [Integer] Used for pagination of query results. Max 100
      #
      # @return [ZombieBattleground::Api::Responses::GetMatchesResponse]
      #
      # @example
      #   response = ZombieBattleground::Api.matches_request(limit: 1)
      #   # => ZombieBattleground::Api::Responses::GetMatchesResponse
      #
      # @api public
      def matches_request(**args)
        @client.matches_request(**args)
      end

      ##
      # Queries for Matches and returns the matches in the response
      #
      # @param id [Integer] Optionally filter on Match id
      # @param player1_id [String] Optionally filter on Match player1_id
      # @param player2_id [String] Optionally filter on Match player2_id
      # @param status [String] Optionally filter on Match status
      # @param version [String] Optionally filter on Match version
      # @param winner_id [String] Optionally filter on Match winner_id
      # @param page [Integer] Used for pagination of query results
      # @param limit [Integer] Used for pagination of query results. Max 100
      #
      # @return [Array<ZombieBattleground::Api::Models::Match>]
      #
      # @example
      #   matches = ZombieBattleground::Api.matches(limit: 1)
      #   # => ZombieBattleground::Api::Models::Match
      #
      # @api public
      def matches(**args)
        matches_request(**args).matches
      end

      ##
      # Queries for a Match and returns the response
      #
      # @param id [Integer] Match id to request
      #
      # @return [ZombieBattleground::Api::Responses::GetMatchResponse]
      #
      # @example
      #   response = ZombieBattleground::Api.match_request(id: 1454)
      #   response # => ZombieBattleground::Api::Responses::GetMatchResponse
      #
      # @api public
      def match_request(**args)
        @client.match_request(**args)
      end

      ##
      # Queries for a Match and returns the match in the response
      #
      # @param id [Integer] Match id to request
      #
      # @return [ZombieBattleground::Api::Models::Match]
      #
      # @example
      #   match = ZombieBattleground::Api.match(id: 1454)
      #   # => ZombieBattleground::Api::Models::Match
      #
      # @api public
      def match(**args)
        match_request(**args).match
      end

      ##
      # Queries for Cards and returns the response
      #
      # @param id [Integer] Optionally filter on Card id
      # @param mould_id [String] Optionally filter on Card mould_id
      # @param version [String] Optionally filter on Card version
      # @param kind [String] Optionally filter on Card kind
      # @param set [String] Optionally filter on Card set
      # @param name [String] Optionally filter on Card name
      # @param rank [String] Optionally filter on Card rank
      # @param type [String] Optionally filter on Card type
      # @param rarity [String] Optionally filter on Card rarity
      # @param damage [Integer] Optionally filter on Card damage
      # @param health [Integer] Optionally filter on Card health
      # @param cost [Integer] Optionally filter on Card cost
      # @param page [Integer] Used for pagination of query results
      # @param limit [Integer] Used for pagination of query results. Max 100
      #
      # @return [ZombieBattleground::Api::Responses::GetCardsResponse]
      #
      # @example
      #   response = ZombieBattleground::Api.cards_request(limit: 1)
      #   # => ZombieBattleground::Api::Responses::GetCardsResponse
      #
      # @api public
      def cards_request(**args)
        @client.cards_request(**args)
      end

      ##
      # Queries for Cards and returns the cards in the response
      #
      # @param id [Integer] Optionally filter on Card id
      # @param mould_id [String] Optionally filter on Card mould_id
      # @param version [String] Optionally filter on Card version
      # @param kind [String] Optionally filter on Card kind
      # @param set [String] Optionally filter on Card set
      # @param name [String] Optionally filter on Card name
      # @param rank [String] Optionally filter on Card rank
      # @param type [String] Optionally filter on Card type
      # @param rarity [String] Optionally filter on Card rarity
      # @param damage [Integer] Optionally filter on Card damage
      # @param health [Integer] Optionally filter on Card health
      # @param cost [Integer] Optionally filter on Card cost
      # @param page [Integer] Used for pagination of query results
      # @param limit [Integer] Used for pagination of query results. Max 100
      #
      # @return [Array<ZombieBattleground::Api::Models::Card>]
      #
      # @example
      #   cards = ZombieBattleground::Api.cards(limit: 1)
      #   # => [ZombieBattleground::Api::Models::Card]
      #
      # @api public
      def cards(**args)
        cards_request(**args).cards
      end

      ##
      # Queries for a Card and returns the response
      #
      # @param mould_id [String] Optionally filter on Card mould_id
      # @param version [String] Optionally filter on Card version
      #
      # @return [ZombieBattleground::Api::Responses::GetCardResponse]
      #
      # @example
      #   response = ZombieBattleground::Api.card(mould_id: 2, version: 'v3')
      #   # => ZombieBattleground::Api::Responses::GetCardResponse
      #
      # @api public
      def card_request(**args)
        @client.card_request(**args)
      end

      ##
      # Queries for a Card and returns the card in the response
      #
      # @param mould_id [String] Optionally filter on Card mould_id
      # @param version [String] Optionally filter on Card version
      #
      # @return [ZombieBattleground::Api::Models::Card]
      #
      # @example
      #   card = ZombieBattleground::Api.card(mould_id: 2, version: 'v3')
      #   # => ZombieBattleground::Api::Models::Card
      #
      # @api public
      def card(**args)
        card_request(**args).card
      end
    end
  end
end
