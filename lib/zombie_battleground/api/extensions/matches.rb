# frozen_string_literal: true

require 'yaml'

require 'zombie_battleground/api/constants'

module ZombieBattleground
  class Api
    module Extensions
      ##
      # API Extensions for Matches
      module Matches
        ##
        # Returns an enumerator for all available matches, accepts a block for yields
        #
        # @return [Enumerator]
        #
        # @example Get an enumerator for the matches
        #   ZombieBattleground::Api.all_matches
        #   # => Enumerator
        #
        # @example Dump all matches as an array
        #   ZombieBattleground::Api.all_matches.to_a
        #   # => [ZombieBattleground::Api::Models::Match]
        #
        # @example Return the first matche
        #   ZombieBattleground::Api.all_matches.first
        #   # => ZombieBattleground::Api::Models::Match
        #
        # @example Pass it a block
        #   ZombieBattleground::Api.all_matches do |match|
        #     do_something_with(match) if match.id == 1
        #   end
        #   # => nil
        #
        # @api public
        def all_matches(**args)
          args.delete(:limit) # query as many as possible
          return enum_for(:all_matches, args) unless block_given?

          page = 1

          loop do
            response = @client.matches_request(args.merge(page: page))
            response.matches.each { |match| yield match }

            break if response.matches.size < PAGE_MAX
            # :nocov:
            page += 1
            # :nocov:
          end
        end

        ##
        # Returns the most recently created matches
        #
        # @param limit [Integer]
        #
        # @return [Array<ZombieBattleground::Api::Models::Match>]
        #
        # @example
        #   two_most_recent = ZombieBattleground::Api.recently_created_matches(3)
        #   # => [ZombieBattleground::Api::Models::Match]
        #
        # @api public
        def recently_created_matches(limit)
          # the `.sort` calls are dodging coverage?...
          # :nocov:
          all_matches.to_a
                     .sort { |a, b| b.created_at <=> a.created_at }
                     .first(limit)
          # :nocov:
        end

        ##
        # Returns the most recently updated matches
        #
        # @param limit [Integer]
        #
        # @return [Array<ZombieBattleground::Api::Models::Match>]
        #
        # @example
        #   two_most_recent = ZombieBattleground::Api.recently_updated_matches(3)
        #   # => [ZombieBattleground::Api::Models::Match]
        #
        # @api public
        def recently_updated_matches(limit)
          # the `.sort` calls are dodging coverage?...
          # :nocov:
          all_matches.to_a
                     .sort { |a, b| b.updated_at <=> a.updated_at }
                     .first(limit)
          # :nocov:
        end

        ##
        # Returns the most recently ended matches
        #
        # @param limit [Integer]
        #
        # @return [Array<ZombieBattleground::Api::Models::Match>]
        #
        # @example
        #   two_most_recent = ZombieBattleground::Api.recently_ended_matches(3)
        #   # => [ZombieBattleground::Api::Models::Match]
        #
        # @api public
        def recently_ended_matches(limit)
          # the `.sort` calls are dodging coverage?...
          # :nocov:
          all_matches.to_a
                     .select { |match| match.status == 'Ended' }
                     .sort { |a, b| b.ended_at <=> a.ended_at }
                     .first(limit)
          # :nocov:
        end

        ##
        # Returns the matches for the player_id
        #
        # @param player_id [String]
        #
        # @return [Array<ZombieBattleground::Api::Models::Match>]
        #
        # @example
        #   player_matches = ZombieBattleground::Api.matches_for_player("ZombieSlayer_5699")
        #   # => [ZombieBattleground::Api::Models::Match]
        #
        # @api public
        def matches_for_player(player_id)
          # the `.sort` calls are dodging coverage?...
          # :nocov:
          all_matches(player1_id: player_id)
            .to_a
            .push(*all_matches(player2_id: player_id).to_a)
            .uniq(&:id)
            .sort { |a, b| b.created_at <=> a.created_at }
          # :nocov:
        end
      end
    end
  end
end
