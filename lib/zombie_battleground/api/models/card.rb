# frozen_string_literal: true

require 'active_record'

require 'zombie_battleground/api/validation_helper'

module ZombieBattleground
  module Api
    ##
    # Validator for Card
    class Card
      include ActiveModel::Validations
      include ZombieBattleground::Api::ValidationHelper

      attr_reader :id, :mould_id, :version, :kind, :set, :name, :description, :flavor_text,
                  :picture, :rank, :type, :rarity, :frame, :damage, :health, :cost,
                  :ability, :block_height, :image_url

      validate :id_is_a_non_negative_integer
      validate :mould_id_is_a_string_and_not_null
      validate :version_is_a_string_and_not_null
      validate :kind_is_a_string_and_not_null
      validate :set_is_a_string_and_not_null
      validate :name_is_a_string_and_not_null
      validate :description_is_a_string_and_not_null
      validate :rank_is_a_string_and_not_null
      validate :type_is_a_string_and_not_null
      validate :rarity_is_a_string_and_not_null
      validate :frame_is_a_string_and_not_null
      validate :damage_is_a_non_negative_integer_and_not_null
      validate :health_is_a_non_negative_integer_and_not_null
      validate :cost_is_a_non_negative_integer_and_not_null
      validate :ability_is_a_string_and_not_null
      validate :block_height_is_a_non_negative_integer_and_not_null
      validate :image_url_is_a_string_and_not_null

      def initialize(card)
        card.each do |key, value|
          next if value.nil? # this is an illegal response, card id 1 is bogus

          instance_variable_set("@#{key}".to_sym, value)
        end
      end
    end
  end
end
