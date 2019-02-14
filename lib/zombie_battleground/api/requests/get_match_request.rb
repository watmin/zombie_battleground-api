# frozen_string_literal: true

require 'active_record'

require 'zombie_battleground/api/validation_helper'
require 'zombie_battleground/api/requests/request_helper'

module ZombieBattleground
  class Api
    class Requests
      ##
      # Request validator for GetMatch
      class GetMatchRequest
        include ActiveModel::Validations
        include ZombieBattleground::Api::ValidationHelper
        include ZombieBattleground::Api::Requests::RequestHelper

        ##
        # @!attribute [r] id
        # Match's id
        #
        # @return [Integer]
        #
        # @example
        #   request.id #=> 1
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
        #   request.uri # => "match/1"
        #
        # @api public
        def uri
          "match/#{id}"
        end

        ##
        # Match does not take params, return an empty Hash
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
