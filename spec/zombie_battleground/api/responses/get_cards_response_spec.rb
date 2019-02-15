# frozen_string_literal: true

require 'zombie_battleground/api/responses/get_cards_response'

RSpec.describe ZombieBattleground::Api::Responses::GetCardsResponse do
  describe '#cards_is_an_array_of_card' do
    it 'fails validation because cards is not an array' do
      response = double(:response, body: '{}', status: 200)
      cards_response = ZombieBattleground::Api::Responses::GetCardsResponse.new(response)
      cards_response.valid?
      expect(cards_response.errors.messages[:cards]).not_to be_empty
    end
  end
end
