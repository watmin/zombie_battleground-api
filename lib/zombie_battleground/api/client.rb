# frozen_string_literal: true

require 'faraday'

require 'zombie_battleground/api/errors'

require 'zombie_battleground/api/requests/get_decks_request'
require 'zombie_battleground/api/responses/get_decks_response'
require 'zombie_battleground/api/requests/get_deck_request'
require 'zombie_battleground/api/responses/get_deck_response'
require 'zombie_battleground/api/requests/get_matches_request'
require 'zombie_battleground/api/responses/get_matches_response'
require 'zombie_battleground/api/requests/get_match_request'
require 'zombie_battleground/api/responses/get_match_response'
require 'zombie_battleground/api/requests/get_cards_request'
require 'zombie_battleground/api/responses/get_cards_response'
require 'zombie_battleground/api/requests/get_card_request'
require 'zombie_battleground/api/responses/get_card_response'

module ZombieBattleground
  class Api
    ##
    # The API Client for Zombie Battleground
    class Client
      ##
      # Creates a new client
      #
      # @return [void]
      #
      # @example
      #   client = ZombieBattleground::Api::Client.new
      #
      # @api public
      def initialize
        @endpoint = 'https://api.loom.games/zb'
        @api_version = 'v1'
      end

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
      # @raise [ZombieBattleground::Api::Errors::InvalidInput, ZombieBattleground::Api::Errors::InvalidResponse]
      #
      # @example
      #   response = client.decks(limit: 1)
      #   response # => ZombieBattleground::Api::Responses::GetDecksResponse
      #
      # @api public
      def decks(**args)
        request = ZombieBattleground::Api::Requests::GetDecksRequest.new
        args.each { |key, val| request.send("#{key}=", val) }
        raise ZombieBattleground::Api::Errors::InvalidInput, request.errors.messages unless request.valid?

        response = connection(uri: request.uri, params: request.params).get
        decks = ZombieBattleground::Api::Responses::GetDecksResponse.new(response)
        raise ZombieBattleground::Api::Errors::InvalidResponse.new(response, decks) unless decks.valid?

        decks
      end

      ##
      # Queries for a Deck
      #
      # @param id [Integer] Deck id to request
      #
      # @return [ZombieBattleground::Api::Responses::GetDeckResponse]
      #
      # @raise [ZombieBattleground::Api::Errors::InvalidInput, ZombieBattleground::Api::Errors::InvalidResponse]
      #
      # @example
      #   response = client.deck(id: 1813)
      #   response # => ZombieBattleground::Api::Responses::GetDeckResponse
      #
      # @api public
      def deck(**args)
        request = ZombieBattleground::Api::Requests::GetDeckRequest.new
        args.each { |key, val| request.send("#{key}=", val) }
        raise ZombieBattleground::Api::Errors::InvalidInput, request.errors.messages unless request.valid?

        response = connection(uri: request.uri, params: request.params).get
        deck = ZombieBattleground::Api::Responses::GetDeckResponse.new(response)
        raise ZombieBattleground::Api::Errors::InvalidResponse.new(response, deck) unless deck.valid?

        deck
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
      # @raise [ZombieBattleground::Api::Errors::InvalidInput, ZombieBattleground::Api::Errors::InvalidResponse]
      #
      # @example
      #   response = client.matches(limit: 1)
      #   response # => ZombieBattleground::Api::Responses::GetMatchesResponse
      #
      # @api public
      def matches(**args)
        request = ZombieBattleground::Api::Requests::GetMatchesRequest.new
        args.each { |key, val| request.send("#{key}=", val) }
        raise ZombieBattleground::Api::Errors::InvalidInput, request.errors.messages unless request.valid?

        response = connection(uri: request.uri, params: request.params).get
        matches = ZombieBattleground::Api::Responses::GetMatchesResponse.new(response)
        raise ZombieBattleground::Api::Errors::InvalidResponse.new(response, matches) unless matches.valid?

        matches
      end

      ##
      # Queries for a Match
      #
      # @param id [Integer] Match id to request
      #
      # @return [ZombieBattleground::Api::Responses::GetMatchResponse]
      #
      # @raise [ZombieBattleground::Api::Errors::InvalidInput, ZombieBattleground::Api::Errors::InvalidResponse]
      #
      # @example
      #   response = client.match(id: 1454)
      #   response # => ZombieBattleground::Api::Responses::GetMatchResponse
      #
      # @api public
      def match(**args)
        request = ZombieBattleground::Api::Requests::GetMatchRequest.new
        args.each { |key, val| request.send("#{key}=", val) }
        raise ZombieBattleground::Api::Errors::InvalidInput, request.errors.messages unless request.valid?

        response = connection(uri: request.uri, params: request.params).get
        match = ZombieBattleground::Api::Responses::GetMatchResponse.new(response)
        raise ZombieBattleground::Api::Errors::InvalidResponse.new(response, match) unless match.valid?

        match
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
      # @raise [ZombieBattleground::Api::Errors::InvalidInput, ZombieBattleground::Api::Errors::InvalidResponse]
      #
      # @example
      #   response = client.cards(limit: 1)
      #   response # => ZombieBattleground::Api::Responses::GetCardsResponse
      #
      # @api public
      def cards(**args)
        request = ZombieBattleground::Api::Requests::GetCardsRequest.new
        args.each { |key, val| request.send("#{key}=", val) }
        raise ZombieBattleground::Api::Errors::InvalidInput, request.errors.messages unless request.valid?

        response = connection(uri: request.uri, params: request.params).get
        cards = ZombieBattleground::Api::Responses::GetCardsResponse.new(response)
        raise ZombieBattleground::Api::Errors::InvalidResponse.new(response, cards) unless cards.valid?

        cards
      end

      ##
      # Queries for a Card
      #
      # @param mould_id [String] Optionally filter on Card mould_id
      # @param version [String] Optionally filter on Card version
      #
      # @return [ZombieBattleground::Api::Responses::GetCardResponse]
      #
      # @raise [ZombieBattleground::Api::Errors::InvalidInput, ZombieBattleground::Api::Errors::InvalidResponse]
      #
      # @example
      #   response = client.card(mould_id: 2, version: 'v3')
      #   response # => ZombieBattleground::Api::Responses::GetCardResponse
      #
      # @api public
      def card(**args)
        request = ZombieBattleground::Api::Requests::GetCardRequest.new
        args.each { |key, val| request.send("#{key}=", val) }
        raise ZombieBattleground::Api::Errors::InvalidInput, request.errors.messages unless request.valid?

        response = connection(uri: request.uri, params: request.params).get
        card = ZombieBattleground::Api::Responses::GetCardResponse.new(response)
        raise ZombieBattleground::Api::Errors::InvalidResponse.new(response, card) unless card.valid?

        card
      end

      private

      ##
      # Creates a new Faraday connection
      #
      # @param uri [String] the URI to append to the endpoint and API version
      # @param params [Hash] the query paramaters for the request
      #
      # @return [Faraday::Connection]
      #
      # @api private
      def connection(uri:, params:)
        Faraday.new(
          url: "#{@endpoint}/#{@api_version}/#{uri}",
          params: params,
          headers: {
            'User-Agent' => "RubyGem-zombie_battleground-api_#{VERSION}",
            'Content-Type' => 'application/json'
          }
        )
      end
    end
  end
end
