# frozen_string_literal: true

require 'zombie_battleground/api'
require 'zombie_battleground/api/extensions/matches'

RSpec.describe ZombieBattleground::Api::Extensions::Matches do
  before(:each) do
    stub_request(:get, 'https://api.loom.games/zb/v1/matches?page=1')
      .to_return(body: read_text('valid_get_matches'))

    stub_request(
      :get, 'https://api.loom.games/zb/v1/matches?page=1' \
      '&player1_id=' \
      'ZombieSlayer_1660102160939616713929530094917607621856109004923959540063468893331468840626'
    ).to_return(body: read_text('valid_get_matches'))

    stub_request(
      :get, 'https://api.loom.games/zb/v1/matches?page=1' \
     '&player2_id=' \
     'ZombieSlayer_1660102160939616713929530094917607621856109004923959540063468893331468840626'
    ).to_return(body: read_text('valid_get_matches'))
  end

  describe '#all_matches' do
    it 'gets them all' do
      matches = ZombieBattleground::Api.all_matches
      expect(matches).to be_a(Enumerator)
      expect(matches.to_a.size).to eq 1
    end
  end

  describe '#recently_created_matches' do
    it 'gets the recently created matches' do
      matches = ZombieBattleground::Api.recently_created_matches(10)
      expect(matches.size).to eq 1
    end
  end

  describe '#recently_updated_matches' do
    it 'gets the recently updated matches' do
      matches = ZombieBattleground::Api.recently_updated_matches(10)
      expect(matches.size).to eq 1
    end
  end

  describe '#recently_ended_matches' do
    it 'gets the recently ended matches' do
      matches = ZombieBattleground::Api.recently_ended_matches(10)
      expect(matches.size).to eq 1
    end
  end

  describe '#matches_for_player' do
    it 'gets the recently ended matches' do
      matches = ZombieBattleground::Api.matches_for_player(
        'ZombieSlayer_1660102160939616713929530094917607621856109004923959540063468893331468840626'
      )
      expect(matches.size).to eq 1
    end
  end
end
