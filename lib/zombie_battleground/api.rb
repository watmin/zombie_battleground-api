# frozen_string_literal: true

require 'zombie_battleground/api/version'
require 'zombie_battleground/api/client'

module ZombieBattleground
  ##
  # API for Zombie Battleground
  class Api
    @client = ZombieBattleground::Api::Client.new

    class << self
      ##
      # Queries for Decks
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
      #   response = ZombieBattleground::Api.decks(limit: 1)
      #   response # => ZombieBattleground::Api::Responses::GetDecksResponse
      #
      # @api public
      def decks(**args)
        @client.decks(**args)
      end

      ##
      # Queries for a Deck
      #
      # @param id [Integer] Deck id to request
      #
      # @return [ZombieBattleground::Api::Responses::GetDeckResponse]
      #
      # @example
      #   response = ZombieBattleground::Api.deck(id: 1813)
      #   response # => ZombieBattleground::Api::Responses::GetDeckResponse
      #
      # @api public
      def deck(**args)
        @client.deck(**args)
      end

      ##
      # Queries for Matches
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
      #   response = ZombieBattleground::Api.matches(limit: 1)
      #   response # => ZombieBattleground::Api::Responses::GetMatchesResponse
      #
      # @api public
      def matches(**args)
        @client.matches(**args)
      end

      ##
      # Queries for a Match
      #
      # @param id [Integer] Match id to request
      #
      # @return [ZombieBattleground::Api::Responses::GetMatchResponse]
      #
      # @example
      #   response = ZombieBattleground::Api.match(id: 1454)
      #   response # => ZombieBattleground::Api::Responses::GetMatchResponse
      #
      # @api public
      def match(**args)
        @client.match(**args)
      end

      ##
      # Queries for Cards
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
      #   response = ZombieBattleground::Api.cards(limit: 1)
      #   response # => ZombieBattleground::Api::Responses::GetCardsResponse
      #
      # @api public
      def cards(**args)
        @client.cards(**args)
      end

      ##
      # Queries for a Card
      #
      # @param mould_id [String] Optionally filter on Card mould_id
      # @param version [String] Optionally filter on Card version
      #
      # @return [ZombieBattleground::Api::Responses::GetCardResponse]
      #
      # @example
      #   response = ZombieBattleground::Api.card(mould_id: 2, version: 'v3')
      #   response # => ZombieBattleground::Api::Responses::GetCardResponse
      #
      # @api public
      def card(**args)
        @client.card(**args)
      end
    end
  end
end
