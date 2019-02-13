# frozen_string_literal: true

require 'active_record'

require 'zombie_battleground/api/validation_helper'
require 'zombie_battleground/api/requests/request_helper'

module ZombieBattleground
  module Api
    ##
    # Request validator for GetDeck
    class GetDeckRequest
      include ActiveModel::Validations
      include ZombieBattleground::Api::ValidationHelper
      include ZombieBattleground::Api::RequestHelper

      attr_accessor :id

      validate :id_is_a_non_negative_integer

      def uri
        "deck/#{id}"
      end

      def params
        {}
      end
    end
  end
end
