# frozen_string_literal: true

require 'active_record'

require 'zombie_battleground/api/validation_helper'
require 'zombie_battleground/api/requests/request_helper'

module ZombieBattleground
  class Api
    ##
    # Request validator for GetDecks
    class GetDecksRequest
      include ActiveModel::Validations
      include ZombieBattleground::Api::ValidationHelper
      include ZombieBattleground::Api::RequestHelper

      attr_accessor :id, :user_id, :deck_id, :name, :hero_id, :primary_skill_id,
                    :secondary_skill_id, :version, :page, :limit

      validate :id_is_a_non_negative_integer
      validate :user_id_is_a_string
      validate :deck_id_is_a_non_negative_integer
      validate :name_is_a_string
      validate :hero_id_is_a_non_negative_integer
      validate :primary_skill_id_is_a_non_negative_integer
      validate :secondary_skill_id_is_a_non_negative_integer
      validate :version_is_a_string
      validate :page_is_a_non_negative_integer
      validate :limit_is_a_non_negative_integer

      def uri
        'decks'
      end
    end
  end
end
