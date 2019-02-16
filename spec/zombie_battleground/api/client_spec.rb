# frozen_string_literal: true

require 'zombie_battleground/api/client'

RSpec.describe ZombieBattleground::Api::Client do
  before(:each) do
    @client = ZombieBattleground::Api::Client.new

    stub_request(:get, 'https://api.loom.games/zb/v1/decks')
      .to_return(body: read_text('valid_get_decks'))

    stub_request(:get, 'https://api.loom.games/zb/v1/deck/1')
      .to_return(body: read_text('valid_get_deck'))

    stub_request(:get, 'https://api.loom.games/zb/v1/matches')
      .to_return(body: read_text('valid_get_matches'))

    stub_request(:get, 'https://api.loom.games/zb/v1/match/1454')
      .to_return(body: read_text('valid_get_match'))

    stub_request(:get, 'https://api.loom.games/zb/v1/cards')
      .to_return(body: read_text('valid_get_cards'))

    stub_request(:get, 'https://api.loom.games/zb/v1/card?mould_id=1&version=v3')
      .to_return(body: read_text('valid_get_card'))
  end

  describe '#decks_request' do
    it 'makes a valid request' do
      response = @client.decks_request
      expect(response).to be_a(ZombieBattleground::Api::Responses::GetDecksResponse)
      expect(response.decks.size).to eq 1
      expect(response.decks.first.cards.size).to eq 27
    end

    it 'makes an invalid request' do
      expect do
        @client.decks_request(id: 'not a number')
      end.to raise_error(ZombieBattleground::Api::Errors::InvalidInput)
    end

    it 'gets an invalid response' do
      stub_request(:get, 'https://api.loom.games/zb/v1/decks')
        .to_return(body: read_text('invalid_get_decks'))

      expect do
        @client.decks_request(remove_invalid: false)
      end.to raise_error(ZombieBattleground::Api::Errors::InvalidResponse)
    end
  end

  describe '#deck_request' do
    it 'makes a valid request' do
      response = @client.deck_request(id: 1)
      expect(response).to be_a(ZombieBattleground::Api::Responses::GetDeckResponse)
      expect(response.deck.cards.size).to eq 27
    end

    it 'makes an invalid request' do
      expect do
        @client.deck_request(id: 'not a number')
      end.to raise_error(ZombieBattleground::Api::Errors::InvalidInput)
    end

    it 'gets an invalid response' do
      stub_request(:get, 'https://api.loom.games/zb/v1/deck/1')
        .to_return(body: read_text('invalid_get_deck'))

      expect do
        @client.deck_request(id: 1)
      end.to raise_error(ZombieBattleground::Api::Errors::InvalidResponse)
    end
  end

  describe '#matches_request' do
    it 'makes a valid request' do
      response = @client.matches_request
      expect(response).to be_a(ZombieBattleground::Api::Responses::GetMatchesResponse)
      expect(response.matches.size).to eq 1
      expect(response.matches.first.id).to eq 1454
    end

    it 'makes an invalid request' do
      expect do
        @client.matches_request(id: 'not a number')
      end.to raise_error(ZombieBattleground::Api::Errors::InvalidInput)
    end

    it 'gets an invalid response' do
      stub_request(:get, 'https://api.loom.games/zb/v1/matches')
        .to_return(body: read_text('invalid_get_matches'))

      expect do
        @client.matches_request(remove_invalid: false)
      end.to raise_error(ZombieBattleground::Api::Errors::InvalidResponse)
    end
  end

  describe '#match_request' do
    it 'makes a valid request' do
      response = @client.match_request(id: 1454)
      expect(response).to be_a(ZombieBattleground::Api::Responses::GetMatchResponse)
      expect(response.match.id).to eq 1454
    end

    it 'makes an invalid request' do
      expect do
        @client.match_request(id: 'not a number')
      end.to raise_error(ZombieBattleground::Api::Errors::InvalidInput)
    end

    it 'gets an invalid response' do
      stub_request(:get, 'https://api.loom.games/zb/v1/match/1454')
        .to_return(body: read_text('invalid_get_match'))

      expect do
        @client.match_request(id: 1454)
      end.to raise_error(ZombieBattleground::Api::Errors::InvalidResponse)
    end
  end

  describe '#cards_request' do
    it 'makes a valid request' do
      response = @client.cards_request
      expect(response).to be_a(ZombieBattleground::Api::Responses::GetCardsResponse)
      expect(response.cards.size).to eq 1
      expect(response.cards.first.id).to eq 1
    end

    it 'makes an invalid request' do
      expect do
        @client.cards_request(mould_id: 1)
      end.to raise_error(ZombieBattleground::Api::Errors::InvalidInput)
    end

    it 'gets an invalid response' do
      stub_request(:get, 'https://api.loom.games/zb/v1/cards')
        .to_return(body: read_text('invalid_get_cards'))

      expect do
        @client.cards_request(remove_invalid: false)
      end.to raise_error(ZombieBattleground::Api::Errors::InvalidResponse)
    end
  end

  describe '#card_request' do
    it 'makes a valid request' do
      response = @client.card_request(mould_id: '1', version: 'v3')
      expect(response).to be_a(ZombieBattleground::Api::Responses::GetCardResponse)
      expect(response.card.id).to eq 2
    end

    it 'makes an invalid request' do
      expect do
        @client.card_request(mould_id: 1)
      end.to raise_error(ZombieBattleground::Api::Errors::InvalidInput)
    end

    it 'gets an invalid response' do
      stub_request(:get, 'https://api.loom.games/zb/v1/card?mould_id=1&version=v3')
        .to_return(body: read_text('invalid_get_card'))

      expect do
        @client.card_request(mould_id: '1', version: 'v3')
      end.to raise_error(ZombieBattleground::Api::Errors::InvalidResponse)
    end
  end
end
