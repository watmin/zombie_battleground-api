# frozen_string_literal: true

require 'zombie_battleground/api/responses/get_decks_response'

RSpec.describe ZombieBattleground::Api::Responses::GetDecksResponse do
  describe '#decks_is_an_array_of_deck' do
    it 'fails validation because decks is not an array' do
      response = double(:response, body: '{}', status: 200)
      decks_response = ZombieBattleground::Api::Responses::GetDecksResponse.new(response)
      decks_response.valid?
      expect(decks_response.errors.messages[:decks]).not_to be_empty
    end
  end
end
