# frozen_string_literal: true

require 'zombie_battleground/api'
require 'zombie_battleground/api/extensions/cards'

RSpec.describe ZombieBattleground::Api::Extensions::Cards do
  before(:each) do
    stub_request(:get, 'https://api.loom.games/zb/v1/cards?page=1')
      .to_return(body: read_text('valid_get_cards'))

    stub_request(:get, 'https://api.loom.games/zb/v1/cards?kind=CREATURE&page=1')
      .to_return(body: read_text('valid_get_cards'))

    stub_request(:get, 'https://api.loom.games/zb/v1/cards?rank=MINION&page=1')
      .to_return(body: read_text('valid_get_cards'))

    stub_request(:get, 'https://api.loom.games/zb/v1/cards?set=AIR&page=1')
      .to_return(body: read_text('valid_get_cards'))

    stub_request(:get, 'https://api.loom.games/zb/v1/cards?type=WALKER&page=1')
      .to_return(body: read_text('valid_get_cards'))

    stub_request(:get, 'https://api.loom.games/zb/v1/cards?rarity=&page=1')
      .to_return(body: read_text('valid_get_cards'))
  end

  describe '#all_cards' do
    it 'gets them all' do
      cards = ZombieBattleground::Api.all_cards
      expect(cards).to be_a(Enumerator)
      expect(cards.to_a.size).to eq 1
    end
  end

  describe '#card_kinds' do
    it 'finds all kinds from all cards' do
      kinds = ZombieBattleground::Api.card_kinds
      expect(kinds.size).to eq 1
      expect(kinds.first).to eq 'CREATURE'
    end
  end

  describe '#card_ranks' do
    it 'finds all ranks from all cards' do
      ranks = ZombieBattleground::Api.card_ranks
      expect(ranks.size).to eq 1
      expect(ranks.first).to eq 'MINION'
    end
  end

  describe '#card_sets' do
    it 'finds all sets from all cards' do
      sets = ZombieBattleground::Api.card_sets
      expect(sets.size).to eq 1
      expect(sets.first).to eq 'AIR'
    end
  end

  describe '#card_types' do
    it 'finds all types from all cards' do
      types = ZombieBattleground::Api.card_types
      expect(types.size).to eq 1
      expect(types.first).to eq 'WALKER'
    end
  end

  describe '#card_rarities' do
    it 'finds all rarities from all cards' do
      rarities = ZombieBattleground::Api.card_rarities
      expect(rarities.size).to eq 1
      expect(rarities.first).to eq ''
    end
  end

  describe '#cards_by_kind' do
    it 'finds all cards of a kind' do
      cards = ZombieBattleground::Api.cards_by_kind(kind: 'CREATURE')
      expect(cards.size).to eq 1
    end
  end

  describe '#cards_by_rank' do
    it 'finds all cards of a rank' do
      cards = ZombieBattleground::Api.cards_by_rank(rank: 'MINION')
      expect(cards.size).to eq 1
    end
  end

  describe '#cards_by_set' do
    it 'finds all cards of a set' do
      cards = ZombieBattleground::Api.cards_by_set(set: 'AIR')
      expect(cards.size).to eq 1
    end
  end

  describe '#cards_by_type' do
    it 'finds all cards of a type' do
      cards = ZombieBattleground::Api.cards_by_type(type: 'WALKER')
      expect(cards.size).to eq 1
    end
  end

  describe '#cards_by_rarity' do
    it 'finds all cards of a rarity' do
      cards = ZombieBattleground::Api.cards_by_rarity(rarity: '')
      expect(cards.size).to eq 1
    end
  end
end
