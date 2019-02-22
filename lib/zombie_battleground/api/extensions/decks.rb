# frozen_string_literal: true

require 'zombie_battleground/api/constants'

module ZombieBattleground
  class Api
    module Extensions
      ##
      # API Extensions for Decks
      module Decks
        ##
        # Returns an enumerator for all available decks, accepts a block for yields
        #
        # @return [Enumerator]
        #
        # @example Get an enumerator for the decks
        #   ZombieBattleground::Api.all_decks
        #   # => Enumerator
        #
        # @example Dump all decks as an array
        #   ZombieBattleground::Api.all_decks.to_a
        #   # => [ZombieBattleground::Api::Models::Deck]
        #
        # @example Return the first deck
        #   ZombieBattleground::Api.all_decks.first
        #   # => ZombieBattleground::Api::Models::Deck
        #
        # @example Pass it a block
        #   ZombieBattleground::Api.all_decks do |deck|
        #     do_something_with(deck) if deck.id == 1
        #   end
        #   # => nil
        #
        # @api public
        def all_decks(**args)
          args.delete(:limit) # query as many as possible
          return enum_for(:all_decks, args) unless block_given?

          page = 1

          loop do
            response = @client.decks_request(args.merge(page: page))
            response.decks.each { |deck| yield deck }

            break if response.decks_count < PAGE_MAX
            # :nocov:
            page += 1
            # :nocov:
          end
        end
      end
    end
  end
end
