# frozen_string_literal: true

require 'zombie_battleground/api/client'
require 'zombie_battleground/api/responses/response_helper'

RSpec.describe ZombieBattleground::Api::Responses::ResponseHelper do
  before(:each) do
    @client = ZombieBattleground::Api::Client.new
  end

  describe '#handle_errors' do
    it 'gets a 400' do
      stub_request(:get, 'https://api.loom.games/zb/v1/card?mould_id=1&version=v3')
        .to_return(body: read_text('invalid_get_card'), status: 400)

      expect do
        @client.card_request(mould_id: '1', version: 'v3')
      end.to raise_error(ZombieBattleground::Api::Errors::BadRequest)
    end

    it 'gets a 404' do
      stub_request(:get, 'https://api.loom.games/zb/v1/card?mould_id=1&version=v3')
        .to_return(body: read_text('invalid_get_card'), status: 404)

      expect do
        @client.card_request(mould_id: '1', version: 'v3')
      end.to raise_error(ZombieBattleground::Api::Errors::NotFound)
    end

    it 'gets a 500' do
      stub_request(:get, 'https://api.loom.games/zb/v1/card?mould_id=1&version=v3')
        .to_return(body: read_text('invalid_get_card'), status: 500)

      expect do
        @client.card_request(mould_id: '1', version: 'v3')
      end.to raise_error(ZombieBattleground::Api::Errors::InternalServerError)
    end

    it 'gets a 503' do
      stub_request(:get, 'https://api.loom.games/zb/v1/card?mould_id=1&version=v3')
        .to_return(body: read_text('invalid_get_card'), status: 503)

      expect do
        @client.card_request(mould_id: '1', version: 'v3')
      end.to raise_error(ZombieBattleground::Api::Errors::ServiceUnavailable)
    end

    it 'gets an unknown status code' do
      stub_request(:get, 'https://api.loom.games/zb/v1/card?mould_id=1&version=v3')
        .to_return(body: read_text('invalid_get_card'), status: 600)

      expect do
        @client.card_request(mould_id: '1', version: 'v3')
      end.to raise_error(ZombieBattleground::Api::Errors::UnknownResponse)
    end
  end
end
