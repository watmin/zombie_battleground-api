# frozen_string_literal: true

require 'active_record'

require 'zombie_battleground/api/validation_helper'
require 'zombie_battleground/api/requests/request_helper'

module ZombieBattleground
  module Api
    ##
    # Request validator for GetMatches
    class GetMatchesRequest
      include ActiveModel::Validations
      include ZombieBattleground::Api::ValidationHelper
      include ZombieBattleground::Api::RequestHelper

      attr_accessor :id, :player1_id, :player2_id, :status, :version, :winner_id,
                    :total, :page, :limit

      validate :id_is_a_non_negative_integer
      validate :player1_id_is_a_string
      validate :player2_id_is_a_string
      validate :status_is_a_string
      validate :version_is_a_string
      validate :winner_id_is_a_string
      validate :page_is_a_non_negative_integer
      validate :limit_is_a_non_negative_integer

      def uri
        'matches'
      end
    end
  end
end
