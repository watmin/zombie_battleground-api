# frozen_string_literal: true

require 'zombie_battleground/api/version'
require 'zombie_battleground/api/client'

module ZombieBattleground
  ##
  # API for Zombie Battleground
  class Api
    @client = ZombieBattleground::Api::Client.new

    class << self
      attr_accessor :client

      def decks(**args)
        client.decks(**args)
      end

      def deck(**args)
        client.deck(**args)
      end

      def matches(**args)
        client.matches(**args)
      end

      def match(**args)
        client.match(**args)
      end

      def cards(**args)
        client.cards(**args)
      end

      def card(**args)
        client.card(**args)
      end
    end
  end
end
