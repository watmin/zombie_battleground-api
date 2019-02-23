# frozen_string_literal: true

require 'zombie_battleground/api'
require 'zombie_battleground/api/extensions/decks'

RSpec.describe ZombieBattleground::Api::Extensions::Decks do
  before(:each) do
    stub_request(:get, 'https://api.loom.games/zb/v1/decks?page=1')
      .to_return(body: read_text('valid_get_decks'))
  end

  describe '#all_decks' do
    it 'gets them all' do
      decks = ZombieBattleground::Api.all_decks
      expect(decks).to be_a(Enumerator)
      expect(decks.to_a.size).to eq 1
    end
  end

  describe '#deck_faction' do
    it 'gets the TOXIC faction from 4' do
      faction = ZombieBattleground::Api.deck_faction(4)
      expect(faction).to eq 'TOXIC'
    end
  end
end
