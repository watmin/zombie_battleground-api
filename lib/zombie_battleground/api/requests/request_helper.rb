# frozen_string_literal: true

module ZombieBattleground
  module Api
    ##
    # Provides generic methods for request validator classes
    module RequestHelper
      BLACKLISTED_INSTANCE_VARIABLES = %w[errors validation_context].freeze

      def params
        instance_variables.map do |var|
          normalized_var = var.to_s.gsub(/^@/, '')
          next if BLACKLISTED_INSTANCE_VARIABLES.include?(normalized_var)

          [normalized_var, instance_variable_get(var)]
        end.compact.to_h
      end
    end
  end
end
