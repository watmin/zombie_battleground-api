# frozen_string_literal: true

require 'zombie_battleground/api'

RSpec.describe ZombieBattleground::Api do
  before(:each) do
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

  describe '.decks_request' do
    it 'returns a decks response object' do
      response = ZombieBattleground::Api.decks_request
      expect(response).to be_a(ZombieBattleground::Api::Responses::GetDecksResponse)
      expect(response.decks.size).to eq 1
      expect(response.decks.first.cards.size).to eq 27
    end
  end

  describe '.decks' do
    it 'returns an array of deck object' do
      decks = ZombieBattleground::Api.decks
      expect(decks).to be_a(Array)
      expect(decks.first).to be_a(ZombieBattleground::Api::Models::Deck)
      expect(decks.size).to eq 1
      expect(decks.first.cards.size).to eq 27
    end
  end

  describe '.deck_request' do
    it 'returns a deck response object' do
      response = ZombieBattleground::Api.deck_request(id: 1)
      expect(response).to be_a(ZombieBattleground::Api::Responses::GetDeckResponse)
      expect(response.deck.cards.size).to eq 11
    end
  end

  describe '.deck' do
    it 'returns a deck object' do
      deck = ZombieBattleground::Api.deck(id: 1)
      expect(deck).to be_a(ZombieBattleground::Api::Models::Deck)
      expect(deck.cards.size).to eq 11
    end
  end

  describe '.matches_request' do
    it 'returns a matches response object' do
      response = ZombieBattleground::Api.matches_request
      expect(response).to be_a(ZombieBattleground::Api::Responses::GetMatchesResponse)
      expect(response.matches.size).to eq 1
      expect(response.matches.first.id).to eq 1454
    end
  end

  describe '.matches' do
    it 'returns an array of match object' do
      matches = ZombieBattleground::Api.matches
      expect(matches).to be_a(Array)
      expect(matches.first).to be_a(ZombieBattleground::Api::Models::Match)
      expect(matches.first.id).to eq 1454
    end
  end

  describe '.match_request' do
    it 'returns a match response object' do
      response = ZombieBattleground::Api.match_request(id: 1454)
      expect(response).to be_a(ZombieBattleground::Api::Responses::GetMatchResponse)
      expect(response.match.id).to eq 1454
    end
  end

  describe '.match' do
    it 'returns a match object' do
      match = ZombieBattleground::Api.match(id: 1454)
      expect(match).to be_a(ZombieBattleground::Api::Models::Match)
      expect(match.id).to eq 1454
    end
  end

  describe '.cards_request' do
    it 'returns a cards response object' do
      response = ZombieBattleground::Api.cards_request
      expect(response).to be_a(ZombieBattleground::Api::Responses::GetCardsResponse)
      expect(response.cards.size).to eq 1
      expect(response.cards.first.id).to eq 1
    end
  end

  describe '.cards' do
    it 'returns an array of card object' do
      cards = ZombieBattleground::Api.cards
      expect(cards).to be_a(Array)
      expect(cards.first).to be_a(ZombieBattleground::Api::Models::Card)
      expect(cards.first.id).to eq 1
    end
  end

  describe '.card_request' do
    it 'returns a card response object' do
      response = ZombieBattleground::Api.card_request(mould_id: '1', version: 'v3')
      expect(response).to be_a(ZombieBattleground::Api::Responses::GetCardResponse)
      expect(response.card.id).to eq 2
    end
  end

  describe '.card' do
    it 'returns a card object' do
      card = ZombieBattleground::Api.card(mould_id: '1', version: 'v3')
      expect(card).to be_a(ZombieBattleground::Api::Models::Card)
      expect(card.id).to eq 2
    end
  end
end
