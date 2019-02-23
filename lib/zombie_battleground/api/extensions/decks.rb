# frozen_string_literal: true

require 'yaml'

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

        ##
        # Return's the deck overlord (hero) type faction
        #
        # @param type [Integer]
        #
        # @return [String}
        #
        # @example
        #   deck_faction(0) # => "EARTH"
        #
        # @api public
        def deck_faction(type)
          load_decks_data['overlord_types'][type]
        end

        ##
        # Return's the deck overlord (hero) faction weakness
        #
        # @param type [Integer]
        #
        # @return [String}
        #
        # @example
        #   deck_weak_against(0) # => "FIRE"
        #
        # @api public
        def deck_weak_against(type)
          load_decks_data['weak_against'][load_decks_data['overlord_types'][type]]
        end

        ##
        # Return's the deck overlord (hero) faction weakness
        #
        # @param type [Integer]
        #
        # @return [String}
        #
        # @example
        #   deck_strong_against(0) # => "AIR"
        #
        # @api public
        def deck_strong_against(type)
          load_decks_data['strong_against'][load_decks_data['overlord_types'][type]]
        end

        private

        ##
        # Loads the helper data for decks
        #
        # @return [Hash]
        #
        # @api private
        def load_decks_data
          @load_decks_data ||= YAML.safe_load(File.read(File.join(__dir__, 'decks.yml')))
        end
      end
    end
  end
end
