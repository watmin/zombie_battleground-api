# frozen_string_literal: true

require 'active_record'
require 'zombie_battleground/api/validation_helper'

##
# Dummy class for testing ZombieBattleground::Api::ValidationHelper
class ValidationHelperDummy
  include ActiveModel::Validations
  include ZombieBattleground::Api::ValidationHelper

  attr_accessor :ability, :amount, :block_height, :card_name, :cost, :created_at, :damage,
                :deck_id, :description, :frame, :health, :hero_id, :id, :image_url, :kind,
                :limit, :mould_id, :name, :page, :player1_deck_id, :player1_id, :player2_deck_id,
                :player2_id, :primary_skill_id, :random_seed, :rank, :rarity, :secondary_skill_id,
                :sender_address, :set, :status, :total, :type, :updated_at, :user_id, :version,
                :winner_id
end

RSpec.describe ZombieBattleground::Api::ValidationHelper do
  before(:each) { @dummy = ValidationHelperDummy.new }

  describe '#value_is_a_class' do
    it 'does not add an error when String is a String' do
      @dummy.version = 'v3'
      @dummy.send(:value_is_a_class, target: :version, value: @dummy.version, klass: String, nullable: false)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'does not add an error when String is nil and nullable is true' do
      @dummy.send(:value_is_a_class, target: :version, value: @dummy.version, klass: String, nullable: true)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'adds an error when String is a not a String' do
      @dummy.send(:value_is_a_class, target: :version, value: @dummy.version, klass: String, nullable: false)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:version]).not_to be_empty
    end
  end

  describe '#value_is_a_string' do
    it 'does not add an error when String is a String' do
      @dummy.version = 'v3'
      @dummy.send(:value_is_a_string, target: :version, value: @dummy.version, nullable: false)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'does not add an error when String is nil and nullable is true' do
      @dummy.send(:value_is_a_string, target: :version, value: @dummy.version, nullable: true)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'adds an error when String is a not a String' do
      @dummy.send(:value_is_a_string, target: :version, value: @dummy.version, nullable: false)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:version]).not_to be_empty
    end
  end

  describe '#value_is_a_time' do
    it 'does not add an error when Time is a Time' do
      @dummy.created_at = Time.at(1_550_045_898)
      @dummy.send(:value_is_a_time, target: :created_at, value: @dummy.created_at, nullable: false)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'does not add an error when Time is nil and nullable is true' do
      @dummy.send(:value_is_a_time, target: :created_at, value: @dummy.created_at, nullable: true)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'adds an error when Time is a not a Time' do
      @dummy.send(:value_is_a_time, target: :created_at, value: @dummy.created_at, nullable: false)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:created_at]).not_to be_empty
    end
  end

  describe '#value_is_an_integer' do
    it 'does not add an error when Integer is a Integer' do
      @dummy.id = 1
      @dummy.send(:value_is_an_integer, target: :id, value: @dummy.id, nullable: false)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'does not add an error when Integer is nil and nullable is true' do
      @dummy.send(:value_is_an_integer, target: :id, value: @dummy.id, nullable: true)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'adds an error when Integer is a not a Integer' do
      @dummy.send(:value_is_an_integer, target: :id, value: @dummy.id, nullable: false)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:id]).not_to be_empty
    end
  end

  describe '#value_is_a_non_negative_integer' do
    it 'is not an integer' do
      @dummy.id = 'one'
      @dummy.send(:value_is_a_non_negative_integer, target: :id, value: @dummy.id, nullable: false)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:id]).not_to be_empty
    end

    it 'is nullable and is nil' do
      @dummy.send(:value_is_a_non_negative_integer, target: :id, value: @dummy.id, nullable: true)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'is zero' do
      @dummy.id = 0
      @dummy.send(:value_is_a_non_negative_integer, target: :id, value: @dummy.id, nullable: false)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'is positive' do
      @dummy.id = 1
      @dummy.send(:value_is_a_non_negative_integer, target: :id, value: @dummy.id, nullable: false)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'is not positive' do
      @dummy.id = -1
      @dummy.send(:value_is_a_non_negative_integer, target: :id, value: @dummy.id, nullable: false)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:id]).not_to be_empty
    end
  end

  describe '#id_is_a_non_negative_integer' do
    it 'does not add an error when Integer is a Integer' do
      @dummy.id = 1
      @dummy.send(:id_is_a_non_negative_integer)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'does not add an error when Integer is nil and nullable is true' do
      @dummy.send(:id_is_a_non_negative_integer)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'adds an error when Integer is a not a Integer' do
      @dummy.id = 'one'
      @dummy.send(:id_is_a_non_negative_integer)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:id]).not_to be_empty
    end
  end

  describe '#id_is_a_non_negative_integer_and_not_null' do
    it 'does not add an error when Integer is a Integer' do
      @dummy.id = 1
      @dummy.send(:id_is_a_non_negative_integer_and_not_null)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'does not add an error when Integer is nil and nullable is true' do
      @dummy.send(:id_is_a_non_negative_integer_and_not_null)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:id]).not_to be_empty
    end

    it 'adds an error when Integer is a not a Integer' do
      @dummy.id = 'one'
      @dummy.send(:id_is_a_non_negative_integer_and_not_null)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:id]).not_to be_empty
    end
  end

  describe '#user_id_is_a_string' do
    it 'does not add an error when String is a String' do
      @dummy.user_id = 'one'
      @dummy.send(:user_id_is_a_string)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'does not add an error when String is nil and nullable is true' do
      @dummy.send(:user_id_is_a_string)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'adds an error when String is a not a String' do
      @dummy.user_id = 1
      @dummy.send(:user_id_is_a_string)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:user_id]).not_to be_empty
    end
  end

  describe '#user_id_is_a_string_and_not_null' do
    it 'does not add an error when String is a String' do
      @dummy.user_id = 'one'
      @dummy.send(:user_id_is_a_string_and_not_null)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'does not add an error when String is nil and nullable is true' do
      @dummy.send(:user_id_is_a_string_and_not_null)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:user_id]).not_to be_empty
    end

    it 'adds an error when String is a not a String' do
      @dummy.user_id = 1
      @dummy.send(:user_id_is_a_string_and_not_null)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:user_id]).not_to be_empty
    end
  end

  describe '#deck_id_is_a_non_negative_integer' do
    it 'does not add an error when Integer is a Integer' do
      @dummy.deck_id = 1
      @dummy.send(:deck_id_is_a_non_negative_integer)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'does not add an error when Integer is nil and nullable is true' do
      @dummy.send(:deck_id_is_a_non_negative_integer)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'adds an error when Integer is a not a Integer' do
      @dummy.deck_id = 'one'
      @dummy.send(:deck_id_is_a_non_negative_integer)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:deck_id]).not_to be_empty
    end
  end

  describe '#deck_id_is_a_non_negative_integer_and_not_null' do
    it 'does not add an error when Integer is a Integer' do
      @dummy.deck_id = 1
      @dummy.send(:deck_id_is_a_non_negative_integer_and_not_null)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'does not add an error when Integer is nil and nullable is true' do
      @dummy.send(:deck_id_is_a_non_negative_integer_and_not_null)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:deck_id]).not_to be_empty
    end

    it 'adds an error when Integer is a not a Integer' do
      @dummy.deck_id = 'one'
      @dummy.send(:deck_id_is_a_non_negative_integer_and_not_null)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:deck_id]).not_to be_empty
    end
  end

  describe '#name_is_a_string' do
    it 'does not add an error when String is a String' do
      @dummy.name = 'one'
      @dummy.send(:name_is_a_string)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'does not add an error when String is nil and nullable is true' do
      @dummy.send(:name_is_a_string)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'adds an error when String is a not a String' do
      @dummy.name = 1
      @dummy.send(:name_is_a_string)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:name]).not_to be_empty
    end
  end

  describe '#name_is_a_string_and_not_null' do
    it 'does not add an error when String is a String' do
      @dummy.name = 'one'
      @dummy.send(:name_is_a_string_and_not_null)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'does not add an error when String is nil and nullable is true' do
      @dummy.send(:name_is_a_string_and_not_null)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:name]).not_to be_empty
    end

    it 'adds an error when String is a not a String' do
      @dummy.name = 1
      @dummy.send(:name_is_a_string_and_not_null)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:name]).not_to be_empty
    end
  end

  describe '#hero_id_is_a_non_negative_integer' do
    it 'does not add an error when Integer is a Integer' do
      @dummy.hero_id = 1
      @dummy.send(:hero_id_is_a_non_negative_integer)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'does not add an error when Integer is nil and nullable is true' do
      @dummy.send(:hero_id_is_a_non_negative_integer)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'adds an error when Integer is a not a Integer' do
      @dummy.hero_id = 'one'
      @dummy.send(:hero_id_is_a_non_negative_integer)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:hero_id]).not_to be_empty
    end
  end

  describe '#hero_id_is_a_non_negative_integer_and_not_null' do
    it 'does not add an error when Integer is a Integer' do
      @dummy.hero_id = 1
      @dummy.send(:hero_id_is_a_non_negative_integer_and_not_null)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'does not add an error when Integer is nil and nullable is true' do
      @dummy.send(:hero_id_is_a_non_negative_integer_and_not_null)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:hero_id]).not_to be_empty
    end

    it 'adds an error when Integer is a not a Integer' do
      @dummy.hero_id = 'one'
      @dummy.send(:hero_id_is_a_non_negative_integer_and_not_null)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:hero_id]).not_to be_empty
    end
  end

  describe '#primary_skill_id_is_a_non_negative_integer' do
    it 'does not add an error when Integer is a Integer' do
      @dummy.primary_skill_id = 1
      @dummy.send(:primary_skill_id_is_a_non_negative_integer)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'does not add an error when Integer is nil and nullable is true' do
      @dummy.send(:primary_skill_id_is_a_non_negative_integer)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'adds an error when Integer is a not a Integer' do
      @dummy.primary_skill_id = 'one'
      @dummy.send(:primary_skill_id_is_a_non_negative_integer)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:primary_skill_id]).not_to be_empty
    end
  end

  describe '#primary_skill_id_is_a_non_negative_integer_and_not_null' do
    it 'does not add an error when Integer is a Integer' do
      @dummy.primary_skill_id = 1
      @dummy.send(:primary_skill_id_is_a_non_negative_integer_and_not_null)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'does not add an error when Integer is nil and nullable is true' do
      @dummy.send(:primary_skill_id_is_a_non_negative_integer_and_not_null)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:primary_skill_id]).not_to be_empty
    end

    it 'adds an error when Integer is a not a Integer' do
      @dummy.primary_skill_id = 'one'
      @dummy.send(:primary_skill_id_is_a_non_negative_integer_and_not_null)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:primary_skill_id]).not_to be_empty
    end
  end

  describe '#secondary_skill_id_is_a_non_negative_integer' do
    it 'does not add an error when Integer is a Integer' do
      @dummy.secondary_skill_id = 1
      @dummy.send(:secondary_skill_id_is_a_non_negative_integer)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'does not add an error when Integer is nil and nullable is true' do
      @dummy.send(:secondary_skill_id_is_a_non_negative_integer)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'adds an error when Integer is a not a Integer' do
      @dummy.secondary_skill_id = 'one'
      @dummy.send(:secondary_skill_id_is_a_non_negative_integer)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:secondary_skill_id]).not_to be_empty
    end
  end

  describe '#secondary_skill_id_is_a_non_negative_integer_and_not_null' do
    it 'does not add an error when Integer is a Integer' do
      @dummy.secondary_skill_id = 1
      @dummy.send(:secondary_skill_id_is_a_non_negative_integer_and_not_null)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'does not add an error when Integer is nil and nullable is true' do
      @dummy.send(:secondary_skill_id_is_a_non_negative_integer_and_not_null)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:secondary_skill_id]).not_to be_empty
    end

    it 'adds an error when Integer is a not a Integer' do
      @dummy.secondary_skill_id = 'one'
      @dummy.send(:secondary_skill_id_is_a_non_negative_integer_and_not_null)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:secondary_skill_id]).not_to be_empty
    end
  end

  describe '#version_is_a_string' do
    it 'does not add an error when String is a String' do
      @dummy.version = 'one'
      @dummy.send(:version_is_a_string)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'does not add an error when String is nil and nullable is true' do
      @dummy.send(:version_is_a_string)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'adds an error when String is a not a String' do
      @dummy.version = 1
      @dummy.send(:version_is_a_string)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:version]).not_to be_empty
    end
  end

  describe '#version_is_a_string_and_not_null' do
    it 'does not add an error when String is a String' do
      @dummy.version = 'one'
      @dummy.send(:version_is_a_string_and_not_null)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'does not add an error when String is nil and nullable is true' do
      @dummy.send(:version_is_a_string_and_not_null)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:version]).not_to be_empty
    end

    it 'adds an error when String is a not a String' do
      @dummy.version = 1
      @dummy.send(:version_is_a_string_and_not_null)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:version]).not_to be_empty
    end
  end

  describe '#total_is_a_non_negative_integer' do
    it 'does not add an error when Integer is a Integer' do
      @dummy.total = 1
      @dummy.send(:total_is_a_non_negative_integer)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'does not add an error when Integer is nil and nullable is true' do
      @dummy.send(:total_is_a_non_negative_integer)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'adds an error when Integer is a not a Integer' do
      @dummy.total = 'one'
      @dummy.send(:total_is_a_non_negative_integer)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:total]).not_to be_empty
    end
  end

  describe '#total_is_a_non_negative_integer_and_not_null' do
    it 'does not add an error when Integer is a Integer' do
      @dummy.total = 1
      @dummy.send(:total_is_a_non_negative_integer_and_not_null)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'does not add an error when Integer is nil and nullable is true' do
      @dummy.send(:total_is_a_non_negative_integer_and_not_null)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:total]).not_to be_empty
    end

    it 'adds an error when Integer is a not a Integer' do
      @dummy.total = 'one'
      @dummy.send(:total_is_a_non_negative_integer_and_not_null)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:total]).not_to be_empty
    end
  end

  describe '#page_is_a_non_negative_integer' do
    it 'does not add an error when Integer is a Integer' do
      @dummy.page = 1
      @dummy.send(:page_is_a_non_negative_integer)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'does not add an error when Integer is nil and nullable is true' do
      @dummy.send(:page_is_a_non_negative_integer)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'adds an error when Integer is a not a Integer' do
      @dummy.page = 'one'
      @dummy.send(:page_is_a_non_negative_integer)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:page]).not_to be_empty
    end
  end

  describe '#page_is_a_non_negative_integer_and_not_null' do
    it 'does not add an error when Integer is a Integer' do
      @dummy.page = 1
      @dummy.send(:page_is_a_non_negative_integer_and_not_null)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'does not add an error when Integer is nil and nullable is true' do
      @dummy.send(:page_is_a_non_negative_integer_and_not_null)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:page]).not_to be_empty
    end

    it 'adds an error when Integer is a not a Integer' do
      @dummy.page = 'one'
      @dummy.send(:page_is_a_non_negative_integer_and_not_null)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:page]).not_to be_empty
    end
  end

  describe '#limit_is_a_non_negative_integer' do
    it 'does not add an error when Integer is a Integer' do
      @dummy.limit = 1
      @dummy.send(:limit_is_a_non_negative_integer)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'does not add an error when Integer is nil and nullable is true' do
      @dummy.send(:limit_is_a_non_negative_integer)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'adds an error when Integer is a not a Integer' do
      @dummy.limit = 'one'
      @dummy.send(:limit_is_a_non_negative_integer)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:limit]).not_to be_empty
    end
  end

  describe '#limit_is_a_non_negative_integer_and_not_null' do
    it 'does not add an error when Integer is a Integer' do
      @dummy.limit = 1
      @dummy.send(:limit_is_a_non_negative_integer_and_not_null)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'does not add an error when Integer is nil and nullable is true' do
      @dummy.send(:limit_is_a_non_negative_integer_and_not_null)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:limit]).not_to be_empty
    end

    it 'adds an error when Integer is a not a Integer' do
      @dummy.limit = 'one'
      @dummy.send(:limit_is_a_non_negative_integer_and_not_null)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:limit]).not_to be_empty
    end
  end

  describe '#card_name_is_a_string' do
    it 'does not add an error when String is a String' do
      @dummy.card_name = 'one'
      @dummy.send(:card_name_is_a_string)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'does not add an error when String is nil and nullable is true' do
      @dummy.send(:card_name_is_a_string)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'adds an error when String is a not a String' do
      @dummy.card_name = 1
      @dummy.send(:card_name_is_a_string)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:card_name]).not_to be_empty
    end
  end

  describe '#card_name_is_a_string_and_not_null' do
    it 'does not add an error when String is a String' do
      @dummy.card_name = 'one'
      @dummy.send(:card_name_is_a_string_and_not_null)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'does not add an error when String is nil and nullable is true' do
      @dummy.send(:card_name_is_a_string_and_not_null)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:card_name]).not_to be_empty
    end

    it 'adds an error when String is a not a String' do
      @dummy.card_name = 1
      @dummy.send(:card_name_is_a_string_and_not_null)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:card_name]).not_to be_empty
    end
  end

  describe '#amount_is_a_non_negative_integer' do
    it 'does not add an error when Integer is a Integer' do
      @dummy.amount = 1
      @dummy.send(:amount_is_a_non_negative_integer)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'does not add an error when Integer is nil and nullable is true' do
      @dummy.send(:amount_is_a_non_negative_integer)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'adds an error when Integer is a not a Integer' do
      @dummy.amount = 'one'
      @dummy.send(:amount_is_a_non_negative_integer)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:amount]).not_to be_empty
    end
  end

  describe '#amount_is_a_non_negative_integer_and_not_null' do
    it 'does not add an error when Integer is a Integer' do
      @dummy.amount = 1
      @dummy.send(:amount_is_a_non_negative_integer_and_not_null)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'does not add an error when Integer is nil and nullable is true' do
      @dummy.send(:amount_is_a_non_negative_integer_and_not_null)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:amount]).not_to be_empty
    end

    it 'adds an error when Integer is a not a Integer' do
      @dummy.amount = 'one'
      @dummy.send(:amount_is_a_non_negative_integer_and_not_null)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:amount]).not_to be_empty
    end
  end

  describe '#sender_address_is_a_string' do
    it 'does not add an error when String is a String' do
      @dummy.sender_address = 'one'
      @dummy.send(:sender_address_is_a_string)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'does not add an error when String is nil and nullable is true' do
      @dummy.send(:sender_address_is_a_string)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'adds an error when String is a not a String' do
      @dummy.sender_address = 1
      @dummy.send(:sender_address_is_a_string)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:sender_address]).not_to be_empty
    end
  end

  describe '#sender_address_is_a_string_and_not_null' do
    it 'does not add an error when String is a String' do
      @dummy.sender_address = 'one'
      @dummy.send(:sender_address_is_a_string_and_not_null)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'does not add an error when String is nil and nullable is true' do
      @dummy.send(:sender_address_is_a_string_and_not_null)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:sender_address]).not_to be_empty
    end

    it 'adds an error when String is a not a String' do
      @dummy.sender_address = 1
      @dummy.send(:sender_address_is_a_string_and_not_null)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:sender_address]).not_to be_empty
    end
  end

  describe '#created_at_is_a_time' do
    it 'does not add an error when Time is a Time' do
      @dummy.created_at = Time.at(1_550_045_898)
      @dummy.send(:created_at_is_a_time)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'does not add an error when Time is nil and nullable is true' do
      @dummy.send(:created_at_is_a_time)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'adds an error when Time is a not a Time' do
      @dummy.created_at = 1
      @dummy.send(:created_at_is_a_time)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:created_at]).not_to be_empty
    end
  end

  describe '#created_at_is_a_time_and_not_null' do
    it 'does not add an error when Time is a Time' do
      @dummy.created_at = Time.at(1_550_045_898)
      @dummy.send(:created_at_is_a_time_and_not_null)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'does not add an error when Time is nil and nullable is true' do
      @dummy.send(:created_at_is_a_time_and_not_null)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:created_at]).not_to be_empty
    end

    it 'adds an error when Time is a not a Time' do
      @dummy.created_at = 1
      @dummy.send(:created_at_is_a_time_and_not_null)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:created_at]).not_to be_empty
    end
  end

  describe '#updated_at_is_a_time' do
    it 'does not add an error when Time is a Time' do
      @dummy.updated_at = Time.at(1_550_045_898)
      @dummy.send(:updated_at_is_a_time)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'does not add an error when Time is nil and nullable is true' do
      @dummy.send(:updated_at_is_a_time)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'adds an error when Time is a not a Time' do
      @dummy.updated_at = 1
      @dummy.send(:updated_at_is_a_time)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:updated_at]).not_to be_empty
    end
  end

  describe '#updated_at_is_a_time_and_not_null' do
    it 'does not add an error when Time is a Time' do
      @dummy.updated_at = Time.at(1_550_045_898)
      @dummy.send(:updated_at_is_a_time_and_not_null)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'does not add an error when Time is nil and nullable is true' do
      @dummy.send(:updated_at_is_a_time_and_not_null)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:updated_at]).not_to be_empty
    end

    it 'adds an error when Time is a not a Time' do
      @dummy.updated_at = 1
      @dummy.send(:updated_at_is_a_time_and_not_null)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:updated_at]).not_to be_empty
    end
  end

  describe '#block_height_is_a_non_negative_integer' do
    it 'does not add an error when Integer is a Integer' do
      @dummy.block_height = 1
      @dummy.send(:block_height_is_a_non_negative_integer)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'does not add an error when Integer is nil and nullable is true' do
      @dummy.send(:block_height_is_a_non_negative_integer)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'adds an error when Integer is a not a Integer' do
      @dummy.block_height = 'one'
      @dummy.send(:block_height_is_a_non_negative_integer)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:block_height]).not_to be_empty
    end
  end

  describe '#block_height_is_a_non_negative_integer_and_not_null' do
    it 'does not add an error when Integer is a Integer' do
      @dummy.block_height = 1
      @dummy.send(:block_height_is_a_non_negative_integer_and_not_null)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'does not add an error when Integer is nil and nullable is true' do
      @dummy.send(:block_height_is_a_non_negative_integer_and_not_null)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:block_height]).not_to be_empty
    end

    it 'adds an error when Integer is a not a Integer' do
      @dummy.block_height = 'one'
      @dummy.send(:block_height_is_a_non_negative_integer_and_not_null)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:block_height]).not_to be_empty
    end
  end

  describe '#player1_id_is_a_string' do
    it 'does not add an error when String is a String' do
      @dummy.player1_id = 'one'
      @dummy.send(:player1_id_is_a_string)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'does not add an error when String is nil and nullable is true' do
      @dummy.send(:player1_id_is_a_string)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'adds an error when String is a not a String' do
      @dummy.player1_id = 1
      @dummy.send(:player1_id_is_a_string)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:player1_id]).not_to be_empty
    end
  end

  describe '#player1_id_is_a_string_and_not_null' do
    it 'does not add an error when String is a String' do
      @dummy.player1_id = 'one'
      @dummy.send(:player1_id_is_a_string_and_not_null)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'does not add an error when String is nil and nullable is true' do
      @dummy.send(:player1_id_is_a_string_and_not_null)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:player1_id]).not_to be_empty
    end

    it 'adds an error when String is a not a String' do
      @dummy.player1_id = 1
      @dummy.send(:player1_id_is_a_string_and_not_null)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:player1_id]).not_to be_empty
    end
  end

  describe '#player2_id_is_a_string' do
    it 'does not add an error when String is a String' do
      @dummy.player2_id = 'one'
      @dummy.send(:player2_id_is_a_string)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'does not add an error when String is nil and nullable is true' do
      @dummy.send(:player2_id_is_a_string)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'adds an error when String is a not a String' do
      @dummy.player2_id = 1
      @dummy.send(:player2_id_is_a_string)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:player2_id]).not_to be_empty
    end
  end

  describe '#player2_id_is_a_string_and_not_null' do
    it 'does not add an error when String is a String' do
      @dummy.player2_id = 'one'
      @dummy.send(:player2_id_is_a_string_and_not_null)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'does not add an error when String is nil and nullable is true' do
      @dummy.send(:player2_id_is_a_string_and_not_null)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:player2_id]).not_to be_empty
    end

    it 'adds an error when String is a not a String' do
      @dummy.player2_id = 1
      @dummy.send(:player2_id_is_a_string_and_not_null)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:player2_id]).not_to be_empty
    end
  end

  describe '#player1_deck_id_is_a_non_negative_integer' do
    it 'does not add an error when Integer is a Integer' do
      @dummy.player1_deck_id = 1
      @dummy.send(:player1_deck_id_is_a_non_negative_integer)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'does not add an error when Integer is nil and nullable is true' do
      @dummy.send(:player1_deck_id_is_a_non_negative_integer)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'adds an error when Integer is a not a Integer' do
      @dummy.player1_deck_id = 'one'
      @dummy.send(:player1_deck_id_is_a_non_negative_integer)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:player1_deck_id]).not_to be_empty
    end
  end

  describe '#player1_deck_id_is_a_non_negative_integer_and_not_null' do
    it 'does not add an error when Integer is a Integer' do
      @dummy.player1_deck_id = 1
      @dummy.send(:player1_deck_id_is_a_non_negative_integer_and_not_null)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'does not add an error when Integer is nil and nullable is true' do
      @dummy.send(:player1_deck_id_is_a_non_negative_integer_and_not_null)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:player1_deck_id]).not_to be_empty
    end

    it 'adds an error when Integer is a not a Integer' do
      @dummy.player1_deck_id = 'one'
      @dummy.send(:player1_deck_id_is_a_non_negative_integer_and_not_null)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:player1_deck_id]).not_to be_empty
    end
  end

  describe '#player2_deck_id_is_a_non_negative_integer' do
    it 'does not add an error when Integer is a Integer' do
      @dummy.player2_deck_id = 1
      @dummy.send(:player2_deck_id_is_a_non_negative_integer)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'does not add an error when Integer is nil and nullable is true' do
      @dummy.send(:player2_deck_id_is_a_non_negative_integer)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'adds an error when Integer is a not a Integer' do
      @dummy.player2_deck_id = 'one'
      @dummy.send(:player2_deck_id_is_a_non_negative_integer)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:player2_deck_id]).not_to be_empty
    end
  end

  describe '#player2_deck_id_is_a_non_negative_integer_and_not_null' do
    it 'does not add an error when Integer is a Integer' do
      @dummy.player2_deck_id = 1
      @dummy.send(:player2_deck_id_is_a_non_negative_integer_and_not_null)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'does not add an error when Integer is nil and nullable is true' do
      @dummy.send(:player2_deck_id_is_a_non_negative_integer_and_not_null)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:player2_deck_id]).not_to be_empty
    end

    it 'adds an error when Integer is a not a Integer' do
      @dummy.player2_deck_id = 'one'
      @dummy.send(:player2_deck_id_is_a_non_negative_integer_and_not_null)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:player2_deck_id]).not_to be_empty
    end
  end

  describe '#random_seed_is_a_non_negative_integer' do
    it 'does not add an error when Integer is a Integer' do
      @dummy.random_seed = 1
      @dummy.send(:random_seed_is_a_non_negative_integer)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'does not add an error when Integer is nil and nullable is true' do
      @dummy.send(:random_seed_is_a_non_negative_integer)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'adds an error when Integer is a not a Integer' do
      @dummy.random_seed = 'one'
      @dummy.send(:random_seed_is_a_non_negative_integer)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:random_seed]).not_to be_empty
    end
  end

  describe '#random_seed_is_a_non_negative_integer_and_not_null' do
    it 'does not add an error when Integer is a Integer' do
      @dummy.random_seed = 1
      @dummy.send(:random_seed_is_a_non_negative_integer_and_not_null)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'does not add an error when Integer is nil and nullable is true' do
      @dummy.send(:random_seed_is_a_non_negative_integer_and_not_null)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:random_seed]).not_to be_empty
    end

    it 'adds an error when Integer is a not a Integer' do
      @dummy.random_seed = 'one'
      @dummy.send(:random_seed_is_a_non_negative_integer_and_not_null)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:random_seed]).not_to be_empty
    end
  end

  describe '#status_is_a_string' do
    it 'does not add an error when String is a String' do
      @dummy.status = 'one'
      @dummy.send(:status_is_a_string)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'does not add an error when String is nil and nullable is true' do
      @dummy.send(:status_is_a_string)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'adds an error when String is a not a String' do
      @dummy.status = 1
      @dummy.send(:status_is_a_string)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:status]).not_to be_empty
    end
  end

  describe '#status_is_a_string_and_not_null' do
    it 'does not add an error when String is a String' do
      @dummy.status = 'one'
      @dummy.send(:status_is_a_string_and_not_null)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'does not add an error when String is nil and nullable is true' do
      @dummy.send(:status_is_a_string_and_not_null)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:status]).not_to be_empty
    end

    it 'adds an error when String is a not a String' do
      @dummy.status = 1
      @dummy.send(:status_is_a_string_and_not_null)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:status]).not_to be_empty
    end
  end

  describe '#winner_id_is_a_string' do
    it 'does not add an error when String is a String' do
      @dummy.winner_id = 'one'
      @dummy.send(:winner_id_is_a_string)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'does not add an error when String is nil and nullable is true' do
      @dummy.send(:winner_id_is_a_string)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'adds an error when String is a not a String' do
      @dummy.winner_id = 1
      @dummy.send(:winner_id_is_a_string)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:winner_id]).not_to be_empty
    end
  end

  describe '#winner_id_is_a_string_and_not_null' do
    it 'does not add an error when String is a String' do
      @dummy.winner_id = 'one'
      @dummy.send(:winner_id_is_a_string_and_not_null)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'does not add an error when String is nil and nullable is true' do
      @dummy.send(:winner_id_is_a_string_and_not_null)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:winner_id]).not_to be_empty
    end

    it 'adds an error when String is a not a String' do
      @dummy.winner_id = 1
      @dummy.send(:winner_id_is_a_string_and_not_null)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:winner_id]).not_to be_empty
    end
  end

  describe '#mould_id_is_a_string' do
    it 'does not add an error when String is a String' do
      @dummy.mould_id = 'one'
      @dummy.send(:mould_id_is_a_string)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'does not add an error when String is nil and nullable is true' do
      @dummy.send(:mould_id_is_a_string)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'adds an error when String is a not a String' do
      @dummy.mould_id = 1
      @dummy.send(:mould_id_is_a_string)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:mould_id]).not_to be_empty
    end
  end

  describe '#mould_id_is_a_string_and_not_null' do
    it 'does not add an error when String is a String' do
      @dummy.mould_id = 'one'
      @dummy.send(:mould_id_is_a_string_and_not_null)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'does not add an error when String is nil and nullable is true' do
      @dummy.send(:mould_id_is_a_string_and_not_null)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:mould_id]).not_to be_empty
    end

    it 'adds an error when String is a not a String' do
      @dummy.mould_id = 1
      @dummy.send(:mould_id_is_a_string_and_not_null)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:mould_id]).not_to be_empty
    end
  end

  describe '#kind_is_a_string' do
    it 'does not add an error when String is a String' do
      @dummy.kind = 'one'
      @dummy.send(:kind_is_a_string)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'does not add an error when String is nil and nullable is true' do
      @dummy.send(:kind_is_a_string)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'adds an error when String is a not a String' do
      @dummy.kind = 1
      @dummy.send(:kind_is_a_string)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:kind]).not_to be_empty
    end
  end

  describe '#kind_is_a_string_and_not_null' do
    it 'does not add an error when String is a String' do
      @dummy.kind = 'one'
      @dummy.send(:kind_is_a_string_and_not_null)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'does not add an error when String is nil and nullable is true' do
      @dummy.send(:kind_is_a_string_and_not_null)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:kind]).not_to be_empty
    end

    it 'adds an error when String is a not a String' do
      @dummy.kind = 1
      @dummy.send(:kind_is_a_string_and_not_null)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:kind]).not_to be_empty
    end
  end

  describe '#set_is_a_string' do
    it 'does not add an error when String is a String' do
      @dummy.set = 'one'
      @dummy.send(:set_is_a_string)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'does not add an error when String is nil and nullable is true' do
      @dummy.send(:set_is_a_string)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'adds an error when String is a not a String' do
      @dummy.set = 1
      @dummy.send(:set_is_a_string)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:set]).not_to be_empty
    end
  end

  describe '#set_is_a_string_and_not_null' do
    it 'does not add an error when String is a String' do
      @dummy.set = 'one'
      @dummy.send(:set_is_a_string_and_not_null)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'does not add an error when String is nil and nullable is true' do
      @dummy.send(:set_is_a_string_and_not_null)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:set]).not_to be_empty
    end

    it 'adds an error when String is a not a String' do
      @dummy.set = 1
      @dummy.send(:set_is_a_string_and_not_null)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:set]).not_to be_empty
    end
  end

  describe '#description_is_a_string' do
    it 'does not add an error when String is a String' do
      @dummy.description = 'one'
      @dummy.send(:description_is_a_string)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'does not add an error when String is nil and nullable is true' do
      @dummy.send(:description_is_a_string)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'adds an error when String is a not a String' do
      @dummy.description = 1
      @dummy.send(:description_is_a_string)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:description]).not_to be_empty
    end
  end

  describe '#description_is_a_string_and_not_null' do
    it 'does not add an error when String is a String' do
      @dummy.description = 'one'
      @dummy.send(:description_is_a_string_and_not_null)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'does not add an error when String is nil and nullable is true' do
      @dummy.send(:description_is_a_string_and_not_null)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:description]).not_to be_empty
    end

    it 'adds an error when String is a not a String' do
      @dummy.description = 1
      @dummy.send(:description_is_a_string_and_not_null)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:description]).not_to be_empty
    end
  end

  describe '#rank_is_a_string' do
    it 'does not add an error when String is a String' do
      @dummy.rank = 'one'
      @dummy.send(:rank_is_a_string)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'does not add an error when String is nil and nullable is true' do
      @dummy.send(:rank_is_a_string)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'adds an error when String is a not a String' do
      @dummy.rank = 1
      @dummy.send(:rank_is_a_string)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:rank]).not_to be_empty
    end
  end

  describe '#rank_is_a_string_and_not_null' do
    it 'does not add an error when String is a String' do
      @dummy.rank = 'one'
      @dummy.send(:rank_is_a_string_and_not_null)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'does not add an error when String is nil and nullable is true' do
      @dummy.send(:rank_is_a_string_and_not_null)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:rank]).not_to be_empty
    end

    it 'adds an error when String is a not a String' do
      @dummy.rank = 1
      @dummy.send(:rank_is_a_string_and_not_null)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:rank]).not_to be_empty
    end
  end

  describe '#type_is_a_string' do
    it 'does not add an error when String is a String' do
      @dummy.type = 'one'
      @dummy.send(:type_is_a_string)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'does not add an error when String is nil and nullable is true' do
      @dummy.send(:type_is_a_string)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'adds an error when String is a not a String' do
      @dummy.type = 1
      @dummy.send(:type_is_a_string)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:type]).not_to be_empty
    end
  end

  describe '#type_is_a_string_and_not_null' do
    it 'does not add an error when String is a String' do
      @dummy.type = 'one'
      @dummy.send(:type_is_a_string_and_not_null)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'does not add an error when String is nil and nullable is true' do
      @dummy.send(:type_is_a_string_and_not_null)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:type]).not_to be_empty
    end

    it 'adds an error when String is a not a String' do
      @dummy.type = 1
      @dummy.send(:type_is_a_string_and_not_null)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:type]).not_to be_empty
    end
  end

  describe '#rarity_is_a_string' do
    it 'does not add an error when String is a String' do
      @dummy.rarity = 'one'
      @dummy.send(:rarity_is_a_string)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'does not add an error when String is nil and nullable is true' do
      @dummy.send(:rarity_is_a_string)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'adds an error when String is a not a String' do
      @dummy.rarity = 1
      @dummy.send(:rarity_is_a_string)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:rarity]).not_to be_empty
    end
  end

  describe '#rarity_is_a_string_and_not_null' do
    it 'does not add an error when String is a String' do
      @dummy.rarity = 'one'
      @dummy.send(:rarity_is_a_string_and_not_null)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'does not add an error when String is nil and nullable is true' do
      @dummy.send(:rarity_is_a_string_and_not_null)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:rarity]).not_to be_empty
    end

    it 'adds an error when String is a not a String' do
      @dummy.rarity = 1
      @dummy.send(:rarity_is_a_string_and_not_null)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:rarity]).not_to be_empty
    end
  end

  describe '#frame_is_a_string' do
    it 'does not add an error when String is a String' do
      @dummy.frame = 'one'
      @dummy.send(:frame_is_a_string)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'does not add an error when String is nil and nullable is true' do
      @dummy.send(:frame_is_a_string)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'adds an error when String is a not a String' do
      @dummy.frame = 1
      @dummy.send(:frame_is_a_string)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:frame]).not_to be_empty
    end
  end

  describe '#frame_is_a_string_and_not_null' do
    it 'does not add an error when String is a String' do
      @dummy.frame = 'one'
      @dummy.send(:frame_is_a_string_and_not_null)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'does not add an error when String is nil and nullable is true' do
      @dummy.send(:frame_is_a_string_and_not_null)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:frame]).not_to be_empty
    end

    it 'adds an error when String is a not a String' do
      @dummy.frame = 1
      @dummy.send(:frame_is_a_string_and_not_null)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:frame]).not_to be_empty
    end
  end

  describe '#damage_is_a_non_negative_integer' do
    it 'does not add an error when Integer is a Integer' do
      @dummy.damage = 1
      @dummy.send(:damage_is_a_non_negative_integer)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'does not add an error when Integer is nil and nullable is true' do
      @dummy.send(:damage_is_a_non_negative_integer)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'adds an error when Integer is a not a Integer' do
      @dummy.damage = 'one'
      @dummy.send(:damage_is_a_non_negative_integer)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:damage]).not_to be_empty
    end
  end

  describe '#damage_is_a_non_negative_integer_and_not_null' do
    it 'does not add an error when Integer is a Integer' do
      @dummy.damage = 1
      @dummy.send(:damage_is_a_non_negative_integer_and_not_null)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'does not add an error when Integer is nil and nullable is true' do
      @dummy.send(:damage_is_a_non_negative_integer_and_not_null)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:damage]).not_to be_empty
    end

    it 'adds an error when Integer is a not a Integer' do
      @dummy.damage = 'one'
      @dummy.send(:damage_is_a_non_negative_integer_and_not_null)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:damage]).not_to be_empty
    end
  end

  describe '#health_is_a_non_negative_integer' do
    it 'does not add an error when Integer is a Integer' do
      @dummy.health = 1
      @dummy.send(:health_is_a_non_negative_integer)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'does not add an error when Integer is nil and nullable is true' do
      @dummy.send(:health_is_a_non_negative_integer)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'adds an error when Integer is a not a Integer' do
      @dummy.health = 'one'
      @dummy.send(:health_is_a_non_negative_integer)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:health]).not_to be_empty
    end
  end

  describe '#health_is_a_non_negative_integer_and_not_null' do
    it 'does not add an error when Integer is a Integer' do
      @dummy.health = 1
      @dummy.send(:health_is_a_non_negative_integer_and_not_null)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'does not add an error when Integer is nil and nullable is true' do
      @dummy.send(:health_is_a_non_negative_integer_and_not_null)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:health]).not_to be_empty
    end

    it 'adds an error when Integer is a not a Integer' do
      @dummy.health = 'one'
      @dummy.send(:health_is_a_non_negative_integer_and_not_null)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:health]).not_to be_empty
    end
  end

  describe '#cost_is_a_non_negative_integer' do
    it 'does not add an error when Integer is a Integer' do
      @dummy.cost = 1
      @dummy.send(:cost_is_a_non_negative_integer)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'does not add an error when Integer is nil and nullable is true' do
      @dummy.send(:cost_is_a_non_negative_integer)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'adds an error when Integer is a not a Integer' do
      @dummy.cost = 'one'
      @dummy.send(:cost_is_a_non_negative_integer)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:cost]).not_to be_empty
    end
  end

  describe '#cost_is_a_non_negative_integer_and_not_null' do
    it 'does not add an error when Integer is a Integer' do
      @dummy.cost = 1
      @dummy.send(:cost_is_a_non_negative_integer_and_not_null)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'does not add an error when Integer is nil and nullable is true' do
      @dummy.send(:cost_is_a_non_negative_integer_and_not_null)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:cost]).not_to be_empty
    end

    it 'adds an error when Integer is a not a Integer' do
      @dummy.cost = 'one'
      @dummy.send(:cost_is_a_non_negative_integer_and_not_null)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:cost]).not_to be_empty
    end
  end

  describe '#ability_is_a_string' do
    it 'does not add an error when String is a String' do
      @dummy.ability = 'one'
      @dummy.send(:ability_is_a_string)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'does not add an error when String is nil and nullable is true' do
      @dummy.send(:ability_is_a_string)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'adds an error when String is a not a String' do
      @dummy.ability = 1
      @dummy.send(:ability_is_a_string)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:ability]).not_to be_empty
    end
  end

  describe '#ability_is_a_string_and_not_null' do
    it 'does not add an error when String is a String' do
      @dummy.ability = 'one'
      @dummy.send(:ability_is_a_string_and_not_null)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'does not add an error when String is nil and nullable is true' do
      @dummy.send(:ability_is_a_string_and_not_null)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:ability]).not_to be_empty
    end

    it 'adds an error when String is a not a String' do
      @dummy.ability = 1
      @dummy.send(:ability_is_a_string_and_not_null)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:ability]).not_to be_empty
    end
  end

  describe '#image_url_is_a_string' do
    it 'does not add an error when String is a String' do
      @dummy.image_url = 'one'
      @dummy.send(:image_url_is_a_string)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'does not add an error when String is nil and nullable is true' do
      @dummy.send(:image_url_is_a_string)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'adds an error when String is a not a String' do
      @dummy.image_url = 1
      @dummy.send(:image_url_is_a_string)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:image_url]).not_to be_empty
    end
  end

  describe '#image_url_is_a_string_and_not_null' do
    it 'does not add an error when String is a String' do
      @dummy.image_url = 'one'
      @dummy.send(:image_url_is_a_string_and_not_null)
      expect(@dummy.errors.messages.empty?).to be true
    end

    it 'does not add an error when String is nil and nullable is true' do
      @dummy.send(:image_url_is_a_string_and_not_null)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:image_url]).not_to be_empty
    end

    it 'adds an error when String is a not a String' do
      @dummy.image_url = 1
      @dummy.send(:image_url_is_a_string_and_not_null)
      expect(@dummy.errors.messages.size).to eq 1
      expect(@dummy.errors.messages[:image_url]).not_to be_empty
    end
  end
end
