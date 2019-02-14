# frozen_string_literal: true

require 'active_record'

require 'zombie_battleground/api/validation_helper'
require 'zombie_battleground/api/requests/request_helper'

module ZombieBattleground
  class Api
    ##
    # Namespace for Requests
    class Requests
      ##
      # Request validator for GetCard
      class GetCardRequest
        include ActiveModel::Validations
        include ZombieBattleground::Api::ValidationHelper
        include ZombieBattleground::Api::Requests::RequestHelper

        ##
        # @!attribute [r] mould_id
        # Card's mould_id
        #
        # @return [String]
        #
        # @example
        #   request.id #=> "1"
        #
        # @api public
        attr_accessor :mould_id

        ##
        # @!attribute [r] version
        # Deck's version
        #
        # @return [String]
        #
        # @example
        #   request.id #=> "v3"
        #
        # @api public
        attr_accessor :version

        validate :mould_id_is_a_string_and_not_null
        validate :version_is_a_string_and_not_null

        ##
        # The URI for the endpoint
        #
        # @return [String]
        #
        # @example
        #   request.uri # => "card"
        #
        # @api public
        def uri
          'card'
        end
      end
    end
  end
end
