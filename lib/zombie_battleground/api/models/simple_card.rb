# frozen_string_literal: true

require 'active_record'

require 'zombie_battleground/api/validation_helper'

module ZombieBattleground
  class Api
    ##
    # Validator for SimpleCard (only returned from GetDeck(s))
    class SimpleCard
      include ActiveModel::Validations
      include ZombieBattleground::Api::ValidationHelper

      attr_reader :card_name, :amount

      validate :card_name_is_a_string_and_not_null
      validate :amount_is_a_non_negative_integer_and_not_null

      def initialize(card)
        card.each do |key, value|
          instance_variable_set("@#{key}".to_sym, value)
        end
      end
    end
  end
end
