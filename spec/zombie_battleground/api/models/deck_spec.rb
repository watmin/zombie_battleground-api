# frozen_string_literal: true

require 'zombie_battleground/api/models/deck'

RSpec.describe ZombieBattleground::Api::Models::Deck do
  describe '#cards_is_an_array_of_simple_card' do
    it 'fails validation because cards is not an array' do
      deck = ZombieBattleground::Api::Models::Deck.new({})
      deck.valid?
      expect(deck.errors.messages[:cards]).not_to be_empty
    end

    it 'fails validation because cards is not made up of cards' do
      deck = ZombieBattleground::Api::Models::Deck.new('cards' => [{}])
      deck.valid?
      expect(deck.errors.messages[:cards]).not_to be_empty
    end
  end
end
