# frozen_string_literal: true

require 'zombie_battleground/api/responses/get_matches_response'

RSpec.describe ZombieBattleground::Api::Responses::GetMatchesResponse do
  describe '#matches_is_an_array_of_match' do
    it 'fails validation because matches is not an array' do
      response = double(:response, body: '{}', status: 200)
      matches_response = ZombieBattleground::Api::Responses::GetMatchesResponse.new(response)
      matches_response.valid?
      expect(matches_response.errors.messages[:matches]).not_to be_empty
    end
  end
end
