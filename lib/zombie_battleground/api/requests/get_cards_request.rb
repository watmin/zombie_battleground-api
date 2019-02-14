# frozen_string_literal: true

require 'active_record'

require 'zombie_battleground/api/validation_helper'
require 'zombie_battleground/api/requests/request_helper'

module ZombieBattleground
  class Api
    ##
    # Request validator for GetCards
    class GetCardsRequest
      include ActiveModel::Validations
      include ZombieBattleground::Api::ValidationHelper
      include ZombieBattleground::Api::RequestHelper

      attr_accessor :id, :mould_id, :version, :kind, :set, :name, :rank, :type, :rarity,
                    :damage, :health, :cost, :page, :limit

      validate :id_is_a_non_negative_integer
      validate :mould_id_is_a_string
      validate :version_is_a_string
      validate :kind_is_a_string
      validate :set_is_a_string
      validate :name_is_a_string
      validate :rank_is_a_string
      validate :type_is_a_string
      validate :rarity_is_a_string
      validate :damage_is_a_non_negative_integer
      validate :health_is_a_non_negative_integer
      validate :cost_is_a_non_negative_integer
      validate :page_is_a_non_negative_integer
      validate :limit_is_a_non_negative_integer

      def uri
        'cards'
      end
    end
  end
end
