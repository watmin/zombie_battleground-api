# frozen_string_literal: true

module ZombieBattleground
  class Api
    ##
    # Validation helpers for sanitizing inputs and ouputs
    module ValidationHelper
      private

      ##
      # Appends an error to the model if the value is not the expected class
      #
      # @param target [Symbol]
      # @param value [Object]
      # @param nullable [Boolean]
      # @param klass [Class]
      #
      # @return [void]
      #
      # @api private
      def value_is_a_class(target:, value:, nullable:, klass:)
        return if (nullable && value.nil?) || value.is_a?(klass)

        errors.add(target, "#{target} must be a #{klass}")
      end

      ##
      # Appends an error to the model if the value is not String
      #
      # @param target [Symbol]
      # @param value [Object]
      # @param nullable [Boolean]
      #
      # @return [void]
      #
      # @api private
      def value_is_a_string(target:, value:, nullable: true)
        value_is_a_class(
          target: target,
          value: value,
          nullable: nullable,
          klass: String
        )
      end

      ##
      # Appends an error to the model if the value is not Time
      #
      # @param target [Symbol]
      # @param value [Object]
      # @param nullable [Boolean]
      #
      # @return [void]
      #
      # @api private
      def value_is_a_time(target:, value:, nullable: true)
        value_is_a_class(
          target: target,
          value: value,
          nullable: nullable,
          klass: Time
        )
      end

      ##
      # Appends an error to the model if the value is not Integer
      #
      # @param target [Symbol]
      # @param value [Object]
      # @param nullable [Boolean]
      #
      # @return [void]
      #
      # @api private
      def value_is_an_integer(target:, value:, nullable: true)
        value_is_a_class(
          target: target,
          value: value,
          nullable: nullable,
          klass: Integer
        )
      end

      ##
      # Appends an error to the model if the value is a negative Integer
      #
      # @param target [Symbol]
      # @param value [Object]
      # @param nullable [Boolean]
      #
      # @return [void]
      #
      # @api private
      def value_is_a_non_negative_integer(target:, value:, nullable: true)
        value_is_an_integer(target: target, value: value, nullable: nullable)
        return unless errors.messages.empty?
        return if nullable && value.nil?
        return if value.zero? || value.positive?

        errors.add(target, "#{target} must be not negative")
      end

      ##
      # Appends an error to the model if id is a negative Integer
      #
      # @return [void]
      #
      # @api private
      def id_is_a_non_negative_integer
        value_is_a_non_negative_integer(target: :id, value: id)
      end

      ##
      # Appends an error to the model if id is a negative Integer or nil
      #
      # @return [void]
      #
      # @api private
      def id_is_a_non_negative_integer_and_not_null
        value_is_a_non_negative_integer(target: :id, value: id, nullable: false)
      end

      ##
      # Appends an error to the model if user_id is not a String
      #
      # @return [void]
      #
      # @api private
      def user_id_is_a_string
        value_is_a_string(target: :user_id, value: user_id)
      end

      ##
      # Appends an error to the model if user_id is not a String or nil
      #
      # @return [void]
      #
      # @api private
      def user_id_is_a_string_and_not_null
        value_is_a_string(target: :user_id, value: user_id, nullable: false)
      end

      ##
      # Appends an error to the model if deck_id is a negative Integer
      #
      # @return [void]
      #
      # @api private
      def deck_id_is_a_non_negative_integer
        value_is_a_non_negative_integer(target: :deck_id, value: deck_id)
      end

      ##
      # Appends an error to the model if deck_id is a negative Integer or nil
      #
      # @return [void]
      #
      # @api private
      def deck_id_is_a_non_negative_integer_and_not_null
        value_is_a_non_negative_integer(target: :deck_id, value: deck_id, nullable: false)
      end

      ##
      # Appends an error to the model if name is not a String
      #
      # @return [void]
      #
      # @api private
      def name_is_a_string
        value_is_a_string(target: :name, value: name)
      end

      ##
      # Appends an error to the model if name is not a String or nil
      #
      # @return [void]
      #
      # @api private
      def name_is_a_string_and_not_null
        value_is_a_string(target: :name, value: name, nullable: false)
      end

      ##
      # Appends an error to the model if hero_id is a negative Integer
      #
      # @return [void]
      #
      # @api private
      def hero_id_is_a_non_negative_integer
        value_is_a_non_negative_integer(target: :hero_id, value: hero_id)
      end

      ##
      # Appends an error to the model if hero_id is a negative Integer or nil
      #
      # @return [void]
      #
      # @api private
      def hero_id_is_a_non_negative_integer_and_not_null
        value_is_a_non_negative_integer(target: :hero_id, value: hero_id, nullable: false)
      end

      ##
      # Appends an error to the model if primary_skill_id is a negative Integer
      #
      # @return [void]
      #
      # @api private
      def primary_skill_id_is_a_non_negative_integer
        value_is_a_non_negative_integer(target: :primary_skill_id, value: primary_skill_id)
      end

      ##
      # Appends an error to the model if primary_skill_id is a negative Integer or nil
      #
      # @return [void]
      #
      # @api private
      def primary_skill_id_is_a_non_negative_integer_and_not_null
        value_is_a_non_negative_integer(target: :primary_skill_id, value: primary_skill_id, nullable: false)
      end

      ##
      # Appends an error to the model if secondary_skill_id is a negative Integer
      #
      # @return [void]
      #
      # @api private
      def secondary_skill_id_is_a_non_negative_integer
        value_is_a_non_negative_integer(target: :secondary_skill_id, value: secondary_skill_id)
      end

      ##
      # Appends an error to the model if secondary_skill_id is a negative Integer or nil
      #
      # @return [void]
      #
      # @api private
      def secondary_skill_id_is_a_non_negative_integer_and_not_null
        value_is_a_non_negative_integer(target: :secondary_skill_id, value: secondary_skill_id, nullable: false)
      end

      ##
      # Appends an error to the model if version is not a String
      #
      # @return [void]
      #
      # @api private
      def version_is_a_string
        value_is_a_string(target: :version, value: version)
      end

      ##
      # Appends an error to the model if version is not a String or nil
      #
      # @return [void]
      #
      # @api private
      def version_is_a_string_and_not_null
        value_is_a_string(target: :version, value: version, nullable: false)
      end

      ##
      # Appends an error to the model if total is a negative Integer
      #
      # @return [void]
      #
      # @api private
      def total_is_a_non_negative_integer
        value_is_a_non_negative_integer(target: :total, value: total)
      end

      ##
      # Appends an error to the model if total is a negative Integer or nil
      #
      # @return [void]
      #
      # @api private
      def total_is_a_non_negative_integer_and_not_null
        value_is_a_non_negative_integer(target: :total, value: total, nullable: false)
      end

      ##
      # Appends an error to the model if page is a negative Integer
      #
      # @return [void]
      #
      # @api private
      def page_is_a_non_negative_integer
        value_is_a_non_negative_integer(target: :page, value: page)
      end

      ##
      # Appends an error to the model if page is a negative Integer or nil
      #
      # @return [void]
      #
      # @api private
      def page_is_a_non_negative_integer_and_not_null
        value_is_a_non_negative_integer(target: :page, value: page, nullable: false)
      end

      ##
      # Appends an error to the model if limit is a negative Integer
      #
      # @return [void]
      #
      # @api private
      def limit_is_a_non_negative_integer
        value_is_a_non_negative_integer(target: :limit, value: limit)
      end

      ##
      # Appends an error to the model if limit is a negative Integer or nil
      #
      # @return [void]
      #
      # @api private
      def limit_is_a_non_negative_integer_and_not_null
        value_is_a_non_negative_integer(target: :limit, value: limit, nullable: false)
      end

      ##
      # Appends an error to the model if card_name is not a String
      #
      # @return [void]
      #
      # @api private
      def card_name_is_a_string
        value_is_a_string(target: :card_name, value: card_name)
      end

      ##
      # Appends an error to the model if card_name is not a String or nil
      #
      # @return [void]
      #
      # @api private
      def card_name_is_a_string_and_not_null
        value_is_a_string(target: :card_name, value: card_name, nullable: false)
      end

      ##
      # Appends an error to the model if amount is a negative Integer
      #
      # @return [void]
      #
      # @api private
      def amount_is_a_non_negative_integer
        value_is_a_non_negative_integer(target: :amount, value: amount)
      end

      ##
      # Appends an error to the model if amount is a negative Integer or nil
      #
      # @return [void]
      #
      # @api private
      def amount_is_a_non_negative_integer_and_not_null
        value_is_a_non_negative_integer(target: :amount, value: amount, nullable: false)
      end

      ##
      # Appends an error to the model if sender_address is not a String
      #
      # @return [void]
      #
      # @api private
      def sender_address_is_a_string
        value_is_a_string(target: :sender_address, value: sender_address)
      end

      ##
      # Appends an error to the model if sender_address is not a String or nil
      #
      # @return [void]
      #
      # @api private
      def sender_address_is_a_string_and_not_null
        value_is_a_string(target: :sender_address, value: sender_address, nullable: false)
      end

      ##
      # Appends an error to the model if created_at is not a Time
      #
      # @return [void]
      #
      # @api private
      def created_at_is_a_time
        value_is_a_time(target: :created_at, value: created_at)
      end

      ##
      # Appends an error to the model if created_at is not a Time or nil
      #
      # @return [void]
      #
      # @api private
      def created_at_is_a_time_and_not_null
        value_is_a_time(target: :created_at, value: created_at, nullable: false)
      end

      ##
      # Appends an error to the model if updated_at is not a Time
      #
      # @return [void]
      #
      # @api private
      def updated_at_is_a_time
        value_is_a_time(target: :updated_at, value: updated_at)
      end

      ##
      # Appends an error to the model if updated_at is not a Time or nil
      #
      # @return [void]
      #
      # @api private
      def updated_at_is_a_time_and_not_null
        value_is_a_time(target: :updated_at, value: updated_at, nullable: false)
      end

      ##
      # Appends an error to the model if block_height is a negative Integer
      #
      # @return [void]
      #
      # @api private
      def block_height_is_a_non_negative_integer
        value_is_a_non_negative_integer(target: :block_height, value: block_height)
      end

      ##
      # Appends an error to the model if block_height is a negative Integer or nil
      #
      # @return [void]
      #
      # @api private
      def block_height_is_a_non_negative_integer_and_not_null
        value_is_a_non_negative_integer(target: :block_height, value: block_height, nullable: false)
      end

      ##
      # Appends an error to the model if player1_id is not a String
      #
      # @return [void]
      #
      # @api private
      def player1_id_is_a_string
        value_is_a_string(target: :player1_id, value: player1_id)
      end

      ##
      # Appends an error to the model if player1_id is not a String or nil
      #
      # @return [void]
      #
      # @api private
      def player1_id_is_a_string_and_not_null
        value_is_a_string(target: :player1_id, value: player1_id, nullable: false)
      end

      ##
      # Appends an error to the model if player2_id is not a String
      #
      # @return [void]
      #
      # @api private
      def player2_id_is_a_string
        value_is_a_string(target: :player2_id, value: player2_id)
      end

      ##
      # Appends an error to the model if player2_id is not a String or nil
      #
      # @return [void]
      #
      # @api private
      def player2_id_is_a_string_and_not_null
        value_is_a_string(target: :player2_id, value: player2_id, nullable: false)
      end

      ##
      # Appends an error to the model if player1_deck_id is a negative Integer
      #
      # @return [void]
      #
      # @api private
      def player1_deck_id_is_a_non_negative_integer
        value_is_a_non_negative_integer(target: :player1_deck_id, value: player1_deck_id)
      end

      ##
      # Appends an error to the model if player1_deck_id is a negative Integer or nil
      #
      # @return [void]
      #
      # @api private
      def player1_deck_id_is_a_non_negative_integer_and_not_null
        value_is_a_non_negative_integer(target: :player1_deck_id, value: player1_deck_id, nullable: false)
      end

      ##
      # Appends an error to the model if player2_deck_id is a negative Integer
      #
      # @return [void]
      #
      # @api private
      def player2_deck_id_is_a_non_negative_integer
        value_is_a_non_negative_integer(target: :player2_deck_id, value: player2_deck_id)
      end

      ##
      # Appends an error to the model if player2_deck_id is a negative Integer or nil
      #
      # @return [void]
      #
      # @api private
      def player2_deck_id_is_a_non_negative_integer_and_not_null
        value_is_a_non_negative_integer(target: :player2_deck_id, value: player2_deck_id, nullable: false)
      end

      ##
      # Appends an error to the model if random_seed is a negative Integer
      #
      # @return [void]
      #
      # @api private
      def random_seed_is_a_non_negative_integer
        value_is_a_non_negative_integer(target: :random_seed, value: random_seed)
      end

      ##
      # Appends an error to the model if random_seed is a negative Integer or nil
      #
      # @return [void]
      #
      # @api private
      def random_seed_is_a_non_negative_integer_and_not_null
        value_is_a_non_negative_integer(target: :random_seed, value: random_seed, nullable: false)
      end

      ##
      # Appends an error to the model if status is not a String
      #
      # @return [void]
      #
      # @api private
      def status_is_a_string
        value_is_a_string(target: :status, value: status)
      end

      ##
      # Appends an error to the model if status is not a String or nil
      #
      # @return [void]
      #
      # @api private
      def status_is_a_string_and_not_null
        value_is_a_string(target: :status, value: status, nullable: false)
      end

      ##
      # Appends an error to the model if winner_id is not a String
      #
      # @return [void]
      #
      # @api private
      def winner_id_is_a_string
        value_is_a_string(target: :winner_id, value: winner_id)
      end

      ##
      # Appends an error to the model if winner_id is not a String or nil
      #
      # @return [void]
      #
      # @api private
      def winner_id_is_a_string_and_not_null
        value_is_a_string(target: :winner_id, value: winner_id, nullable: false)
      end

      ##
      # Appends an error to the model if mould_id is not a String
      #
      # @return [void]
      #
      # @api private
      def mould_id_is_a_string
        value_is_a_string(target: :mould_id, value: mould_id)
      end

      ##
      # Appends an error to the model if mould_id is not a String or nil
      #
      # @return [void]
      #
      # @api private
      def mould_id_is_a_string_and_not_null
        value_is_a_string(target: :mould_id, value: mould_id, nullable: false)
      end

      ##
      # Appends an error to the model if kind is not a String
      #
      # @return [void]
      #
      # @api private
      def kind_is_a_string
        value_is_a_string(target: :kind, value: kind)
      end

      ##
      # Appends an error to the model if kind is not a String or nil
      #
      # @return [void]
      #
      # @api private
      def kind_is_a_string_and_not_null
        value_is_a_string(target: :kind, value: kind, nullable: false)
      end

      ##
      # Appends an error to the model if set is not a String
      #
      # @return [void]
      #
      # @api private
      def set_is_a_string
        value_is_a_string(target: :set, value: set)
      end

      ##
      # Appends an error to the model if set is not a String or nil
      #
      # @return [void]
      #
      # @api private
      def set_is_a_string_and_not_null
        value_is_a_string(target: :set, value: set, nullable: false)
      end

      ##
      # Appends an error to the model if description is not a String
      #
      # @return [void]
      #
      # @api private
      def description_is_a_string
        value_is_a_string(target: :description, value: description)
      end

      ##
      # Appends an error to the model if description is not a String or nil
      #
      # @return [void]
      #
      # @api private
      def description_is_a_string_and_not_null
        value_is_a_string(target: :description, value: description, nullable: false)
      end

      ##
      # Appends an error to the model if rank is not a String
      #
      # @return [void]
      #
      # @api private
      def rank_is_a_string
        value_is_a_string(target: :rank, value: rank)
      end

      ##
      # Appends an error to the model if rank is not a String or nil
      #
      # @return [void]
      #
      # @api private
      def rank_is_a_string_and_not_null
        value_is_a_string(target: :rank, value: rank, nullable: false)
      end

      ##
      # Appends an error to the model if type is not a String
      #
      # @return [void]
      #
      # @api private
      def type_is_a_string
        value_is_a_string(target: :type, value: type)
      end

      ##
      # Appends an error to the model if type is not a String or nil
      #
      # @return [void]
      #
      # @api private
      def type_is_a_string_and_not_null
        value_is_a_string(target: :type, value: type, nullable: false)
      end

      ##
      # Appends an error to the model if rarity is not a String
      #
      # @return [void]
      #
      # @api private
      def rarity_is_a_string
        value_is_a_string(target: :rarity, value: rarity)
      end

      ##
      # Appends an error to the model if rarity is not a String or nil
      #
      # @return [void]
      #
      # @api private
      def rarity_is_a_string_and_not_null
        value_is_a_string(target: :rarity, value: rarity, nullable: false)
      end

      ##
      # Appends an error to the model if frame is not a String
      #
      # @return [void]
      #
      # @api private
      def frame_is_a_string
        value_is_a_string(target: :frame, value: frame)
      end

      ##
      # Appends an error to the model if frame is not a String or nil
      #
      # @return [void]
      #
      # @api private
      def frame_is_a_string_and_not_null
        value_is_a_string(target: :frame, value: frame, nullable: false)
      end

      ##
      # Appends an error to the model if damage is a negative Integer
      #
      # @return [void]
      #
      # @api private
      def damage_is_a_non_negative_integer
        value_is_a_non_negative_integer(target: :damage, value: damage)
      end

      ##
      # Appends an error to the model if damage is a negative Integer or nil
      #
      # @return [void]
      #
      # @api private
      def damage_is_a_non_negative_integer_and_not_null
        value_is_a_non_negative_integer(target: :damage, value: damage, nullable: false)
      end

      ##
      # Appends an error to the model if health is a negative Integer
      #
      # @return [void]
      #
      # @api private
      def health_is_a_non_negative_integer
        value_is_a_non_negative_integer(target: :health, value: health)
      end

      ##
      # Appends an error to the model if health is a negative Integer or nil
      #
      # @return [void]
      #
      # @api private
      def health_is_a_non_negative_integer_and_not_null
        value_is_a_non_negative_integer(target: :health, value: health, nullable: false)
      end

      ##
      # Appends an error to the model if cost is a negative Integer
      #
      # @return [void]
      #
      # @api private
      def cost_is_a_non_negative_integer
        value_is_a_non_negative_integer(target: :cost, value: cost)
      end

      ##
      # Appends an error to the model if cost is a negative Integer or nil
      #
      # @return [void]
      #
      # @api private
      def cost_is_a_non_negative_integer_and_not_null
        value_is_a_non_negative_integer(target: :cost, value: cost, nullable: false)
      end

      ##
      # Appends an error to the model if ability is not a String
      #
      # @return [void]
      #
      # @api private
      def ability_is_a_string
        value_is_a_string(target: :ability, value: ability)
      end

      ##
      # Appends an error to the model if ability is not a String or nil
      #
      # @return [void]
      #
      # @api private
      def ability_is_a_string_and_not_null
        value_is_a_string(target: :ability, value: ability, nullable: false)
      end

      ##
      # Appends an error to the model if image_url is not a String
      #
      # @return [void]
      #
      # @api private
      def image_url_is_a_string
        value_is_a_string(target: :image_url, value: image_url)
      end

      ##
      # Appends an error to the model if image_url is not a String or nil
      #
      # @return [void]
      #
      # @api private
      def image_url_is_a_string_and_not_null
        value_is_a_string(target: :image_url, value: image_url, nullable: false)
      end
    end
  end
end
