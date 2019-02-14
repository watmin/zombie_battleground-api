# frozen_string_literal: true

require 'active_record'

require 'zombie_battleground/api/validation_helper'
require 'zombie_battleground/api/requests/request_helper'

module ZombieBattleground
  class Api
    class Requests
      ##
      # Request validator for GetDeck
      class GetDeckRequest
        include ActiveModel::Validations
        include ZombieBattleground::Api::ValidationHelper
        include ZombieBattleground::Api::Requests::RequestHelper

        ##
        # @!attribute [r] id
        # Deck's id
        #
        # @return [Integer]
        #
        # @example
        #   request.id #=> 1812
        #
        # @api public
        attr_accessor :id

        validate :id_is_a_non_negative_integer

        ##
        # The URI for the endpoint
        #
        # @return [String]
        #
        # @example
        #   request.uri # => "deck/1812"
        #
        # @api public
        def uri
          "deck/#{id}"
        end

        ##
        # Deck does not take params, return an empty Hash
        #
        # @return [Hash]
        #
        # @example
        #   request.params # => {}
        #
        # @api public
        def params
          {}
        end
      end
    end
  end
end
