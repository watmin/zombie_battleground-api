# frozen_string_literal: true

module ZombieBattleground
  class Api
    class Requests
      ##
      # Provides generic methods for request validator classes
      module RequestHelper
        ##
        # Instance variables to skip when computing the model's query paramaters
        BLACKLISTED_INSTANCE_VARIABLES = %w[errors validation_context].freeze

        ##
        # Computes the model's query paramaters
        #
        # @return [Hash]
        #
        # @example
        #   query_params = model.params
        #   query_params # => Hash
        #
        # @api public
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
end
