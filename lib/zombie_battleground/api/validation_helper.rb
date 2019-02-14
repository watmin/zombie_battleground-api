# frozen_string_literal: true

module ZombieBattleground
  class Api
    ##
    # Validation helpers for sanitizing inputs and ouputs
    module ValidationHelper
      def value_is_a_class(target:, value:, nullable:, klass:)
        return if (nullable && value.nil?) || value.is_a?(klass)

        errors.add(target, "#{target} must be a #{klass}")
      end

      def value_is_a_string(target:, value:, nullable: true)
        value_is_a_class(
          target: target,
          value: value,
          nullable: nullable,
          klass: String
        )
      end

      def value_is_a_time(target:, value:, nullable: true)
        value_is_a_class(
          target: target,
          value: value,
          nullable: nullable,
          klass: Time
        )
      end

      def value_is_an_integer(target:, value:, nullable: true)
        value_is_a_class(
          target: target,
          value: value,
          nullable: nullable,
          klass: Integer
        )
      end

      def value_is_a_non_negative_integer(target:, value:, nullable: true)
        value_is_an_integer(target: target, value: value, nullable: nullable)
        return unless errors.messages.empty?
        return if nullable && value.nil?
        return if value.zero? || value.positive?

        errors.add(target, "#{target} must be not negative")
      end

      def id_is_a_non_negative_integer
        value_is_a_non_negative_integer(target: :id, value: id)
      end

      def id_is_a_non_negative_integer_and_not_null
        value_is_a_non_negative_integer(target: :id, value: id, nullable: false)
      end

      def user_id_is_a_string
        value_is_a_string(target: :user_id, value: user_id)
      end

      def user_id_is_a_string_and_not_null
        value_is_a_string(target: :user_id, value: user_id, nullable: false)
      end

      def deck_id_is_a_non_negative_integer
        value_is_a_non_negative_integer(target: :deck_id, value: deck_id)
      end

      def deck_id_is_a_non_negative_integer_and_not_null
        value_is_a_non_negative_integer(target: :deck_id, value: deck_id, nullable: false)
      end

      def name_is_a_string
        value_is_a_string(target: :name, value: name)
      end

      def name_is_a_string_and_not_null
        value_is_a_string(target: :name, value: name, nullable: false)
      end

      def hero_id_is_a_non_negative_integer
        value_is_a_non_negative_integer(target: :hero_id, value: hero_id)
      end

      def hero_id_is_a_non_negative_integer_and_not_null
        value_is_a_non_negative_integer(target: :hero_id, value: hero_id, nullable: false)
      end

      def primary_skill_id_is_a_non_negative_integer
        value_is_a_non_negative_integer(target: :primary_skill_id, value: primary_skill_id)
      end

      def primary_skill_id_is_a_non_negative_integer_and_not_null
        value_is_a_non_negative_integer(target: :primary_skill_id, value: primary_skill_id, nullable: false)
      end

      def secondary_skill_id_is_a_non_negative_integer
        value_is_a_non_negative_integer(target: :secondary_skill_id, value: secondary_skill_id)
      end

      def secondary_skill_id_is_a_non_negative_integer_and_not_null
        value_is_a_non_negative_integer(target: :secondary_skill_id, value: secondary_skill_id, nullable: false)
      end

      def version_is_a_string
        value_is_a_string(target: :version, value: version)
      end

      def version_is_a_string_and_not_null
        value_is_a_string(target: :version, value: version, nullable: false)
      end

      def total_is_a_non_negative_integer
        value_is_a_non_negative_integer(target: :total, value: total)
      end

      def total_is_a_non_negative_integer_and_not_null
        value_is_a_non_negative_integer(target: :total, value: total, nullable: false)
      end

      def page_is_a_non_negative_integer
        value_is_a_non_negative_integer(target: :page, value: page)
      end

      def page_is_a_non_negative_integer_and_not_null
        value_is_a_non_negative_integer(target: :page, value: page, nullable: false)
      end

      def limit_is_a_non_negative_integer
        value_is_a_non_negative_integer(target: :limit, value: limit)
      end

      def limit_is_a_non_negative_integer_and_not_null
        value_is_a_non_negative_integer(target: :limit, value: limit, nullable: false)
      end

      def card_name_is_a_string
        value_is_a_string(target: :card_name, value: card_name)
      end

      def card_name_is_a_string_and_not_null
        value_is_a_string(target: :card_name, value: card_name, nullable: false)
      end

      def amount_is_a_non_negative_integer
        value_is_a_non_negative_integer(target: :amount, value: amount)
      end

      def amount_is_a_non_negative_integer_and_not_null
        value_is_a_non_negative_integer(target: :amount, value: amount, nullable: false)
      end

      def sender_address_is_a_string
        value_is_a_string(target: :sender_address, value: sender_address)
      end

      def sender_address_is_a_string_and_not_null
        value_is_a_string(target: :sender_address, value: sender_address, nullable: false)
      end

      def created_at_is_a_time
        value_is_a_time(target: :created_at, value: created_at)
      end

      def created_at_is_a_time_and_not_null
        value_is_a_time(target: :created_at, value: created_at, nullable: false)
      end

      def updated_at_is_a_time
        value_is_a_time(target: :updated_at, value: updated_at)
      end

      def updated_at_is_a_time_and_not_null
        value_is_a_time(target: :updated_at, value: updated_at, nullable: false)
      end

      def block_height_is_a_non_negative_integer
        value_is_a_non_negative_integer(target: :block_height, value: block_height)
      end

      def block_height_is_a_non_negative_integer_and_not_null
        value_is_a_non_negative_integer(target: :block_height, value: block_height, nullable: false)
      end

      def player1_id_is_a_string
        value_is_a_string(target: :player1_id, value: player1_id)
      end

      def player1_id_is_a_string_and_not_null
        value_is_a_string(target: :player1_id, value: player1_id, nullable: false)
      end

      def player2_id_is_a_string
        value_is_a_string(target: :player2_id, value: player2_id)
      end

      def player2_id_is_a_string_and_not_null
        value_is_a_string(target: :player2_id, value: player2_id, nullable: false)
      end

      def player1_deck_id_is_a_non_negative_integer
        value_is_a_non_negative_integer(target: :player1_deck_id, value: player1_deck_id)
      end

      def player1_deck_id_is_a_non_negative_integer_and_not_null
        value_is_a_non_negative_integer(target: :player1_deck_id, value: player1_deck_id, nullable: false)
      end

      def player2_deck_id_is_a_non_negative_integer
        value_is_a_non_negative_integer(target: :player2_deck_id, value: player2_deck_id)
      end

      def player2_deck_id_is_a_non_negative_integer_and_not_null
        value_is_a_non_negative_integer(target: :player2_deck_id, value: player2_deck_id, nullable: false)
      end

      def random_seed_is_a_non_negative_integer
        value_is_a_non_negative_integer(target: :random_seed, value: random_seed)
      end

      def random_seed_is_a_non_negative_integer_and_not_null
        value_is_a_non_negative_integer(target: :random_seed, value: random_seed, nullable: false)
      end

      def status_is_a_string
        value_is_a_string(target: :status, value: status)
      end

      def status_is_a_string_and_not_null
        value_is_a_string(target: :status, value: status, nullable: false)
      end

      def winner_id_is_a_string
        value_is_a_string(target: :winner_id, value: winner_id)
      end

      def winner_id_is_a_string_and_not_null
        value_is_a_string(target: :winner_id, value: winner_id, nullable: false)
      end

      def mould_id_is_a_string
        value_is_a_string(target: :mould_id, value: mould_id)
      end

      def mould_id_is_a_string_and_not_null
        value_is_a_string(target: :mould_id, value: mould_id, nullable: false)
      end

      def kind_is_a_string
        value_is_a_string(target: :kind, value: kind)
      end

      def kind_is_a_string_and_not_null
        value_is_a_string(target: :kind, value: kind, nullable: false)
      end

      def set_is_a_string
        value_is_a_string(target: :set, value: set)
      end

      def set_is_a_string_and_not_null
        value_is_a_string(target: :set, value: set, nullable: false)
      end

      def description_is_a_string
        value_is_a_string(target: :description, value: description)
      end

      def description_is_a_string_and_not_null
        value_is_a_string(target: :description, value: description, nullable: false)
      end

      def rank_is_a_string
        value_is_a_string(target: :rank, value: rank)
      end

      def rank_is_a_string_and_not_null
        value_is_a_string(target: :rank, value: rank, nullable: false)
      end

      def type_is_a_string
        value_is_a_string(target: :type, value: type)
      end

      def type_is_a_string_and_not_null
        value_is_a_string(target: :type, value: type, nullable: false)
      end

      def rarity_is_a_string
        value_is_a_string(target: :rarity, value: rarity)
      end

      def rarity_is_a_string_and_not_null
        value_is_a_string(target: :rarity, value: rarity, nullable: false)
      end

      def frame_is_a_string
        value_is_a_string(target: :frame, value: frame)
      end

      def frame_is_a_string_and_not_null
        value_is_a_string(target: :frame, value: frame, nullable: false)
      end

      def damage_is_a_non_negative_integer
        value_is_a_non_negative_integer(target: :damage, value: damage)
      end

      def damage_is_a_non_negative_integer_and_not_null
        value_is_a_non_negative_integer(target: :damage, value: damage, nullable: false)
      end

      def health_is_a_non_negative_integer
        value_is_a_non_negative_integer(target: :health, value: health)
      end

      def health_is_a_non_negative_integer_and_not_null
        value_is_a_non_negative_integer(target: :health, value: health, nullable: false)
      end

      def cost_is_a_non_negative_integer
        value_is_a_non_negative_integer(target: :cost, value: cost)
      end

      def cost_is_a_non_negative_integer_and_not_null
        value_is_a_non_negative_integer(target: :cost, value: cost, nullable: false)
      end

      def ability_is_a_string
        value_is_a_string(target: :ability, value: ability)
      end

      def ability_is_a_string_and_not_null
        value_is_a_string(target: :ability, value: ability, nullable: false)
      end

      def image_url_is_a_string
        value_is_a_string(target: :image_url, value: image_url)
      end

      def image_url_is_a_string_and_not_null
        value_is_a_string(target: :image_url, value: image_url, nullable: false)
      end
    end
  end
end
