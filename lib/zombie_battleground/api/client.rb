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
  module Api
    ##
    # The API Client for Zombie Battleground
    class Client
      def initialize
        @endpoint = 'https://api.loom.games/zb'
        @api_version = 'v1'
      end

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

      def decks(**args)
        request = ZombieBattleground::Api::GetDecksRequest.new
        args.each { |key, val| request.send("#{key}=", val) }
        raise ZombieBattleground::Api::Errors::InvalidInput, request.errors.messages unless request.valid?

        response = connection(uri: request.uri, params: request.params).get
        decks = ZombieBattleground::Api::GetDecksResponse.new(response)
        raise ZombieBattleground::Api::Errors::InvalidResponse.new(response, decks) unless decks.valid?

        decks
      end

      def deck(id:)
        request = ZombieBattleground::Api::GetDeckRequest.new
        request.id = id
        raise ZombieBattleground::Api::Errors::InvalidInput, request.errors.messages unless request.valid?

        response = connection(uri: request.uri, params: request.params).get
        deck = ZombieBattleground::Api::GetDeckResponse.new(response)
        raise ZombieBattleground::Api::Errors::InvalidResponse.new(response, deck) unless deck.valid?

        deck
      end

      def matches(**args)
        request = ZombieBattleground::Api::GetMatchesRequest.new
        args.each { |key, val| request.send("#{key}=", val) }
        raise ZombieBattleground::Api::Errors::InvalidInput, request.errors.messages unless request.valid?

        response = connection(uri: request.uri, params: request.params).get
        matches = ZombieBattleground::Api::GetMatchesResponse.new(response)
        raise ZombieBattleground::Api::Errors::InvalidResponse.new(response, matches) unless matches.valid?

        matches
      end

      def match(id:)
        request = ZombieBattleground::Api::GetMatchRequest.new
        request.id = id
        raise ZombieBattleground::Api::Errors::InvalidInput, request.errors.messages unless request.valid?

        response = connection(uri: request.uri, params: request.params).get
        match = ZombieBattleground::Api::GetMatchResponse.new(response)
        raise ZombieBattleground::Api::Errors::InvalidResponse.new(response, match) unless match.valid?

        match
      end

      def cards(**args)
        request = ZombieBattleground::Api::GetCardsRequest.new
        args.each { |key, val| request.send("#{key}=", val) }
        raise ZombieBattleground::Api::Errors::InvalidInput, request.errors.messages unless request.valid?

        response = connection(uri: request.uri, params: request.params).get
        cards = ZombieBattleground::Api::GetCardsResponse.new(response)
        raise ZombieBattleground::Api::Errors::InvalidResponse.new(response, cards) unless cards.valid?

        cards
      end

      def card(**args)
        request = ZombieBattleground::Api::GetCardRequest.new
        args.each { |key, val| request.send("#{key}=", val) }
        raise ZombieBattleground::Api::Errors::InvalidInput, request.errors.messages unless request.valid?

        response = connection(uri: request.uri, params: request.params).get
        card = ZombieBattleground::Api::GetCardResponse.new(response)
        raise ZombieBattleground::Api::Errors::InvalidResponse.new(response, card) unless card.valid?

        card
      end
    end
  end
end
