# frozen_string_literal: true

require 'active_record'

require 'zombie_battleground/api/validation_helper'
require 'zombie_battleground/api/requests/request_helper'

module ZombieBattleground
  module Api
    ##
    # Request validator for GetCard
    class GetCardRequest
      include ActiveModel::Validations
      include ZombieBattleground::Api::ValidationHelper
      include ZombieBattleground::Api::RequestHelper

      attr_accessor :mould_id, :version

      validate :mould_id_is_a_string_and_not_null
      validate :version_is_a_string_and_not_null

      def uri
        'card'
      end
    end
  end
end
