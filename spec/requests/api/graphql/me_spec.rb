# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'POST /api/graphql' do
  let(:query) do
    <<~GRAPHQL
      query {
        me {
          email
        }
      }
    GRAPHQL
  end

  let(:data)    { JSON.parse(response.body)['data'] }
  let(:error)   { JSON.parse(response.body)['error'] }
  let(:user)    { create(:user).reload }
  let(:exp)     { 2.hours.from_now.to_i }
  let(:token)   { JWT.encode({ 'user_id' => user.id, exp: exp }, secret) }
  let(:secret)  { Rails.application.secrets.secret_key_base }
  let(:headers) { { 'Authorization' => "Bearer #{token}" } }

  context 'with valid token' do
    it 'returns user' do
      post '/api/graphql', params: { query: query }, headers: headers

      expect(response.status).to eq 200
      expect(error).to be_nil
      expect(data['me']['email']).to eq user.email
    end
  end

  context 'without token' do
    let(:headers) { {} }

    it 'returns auth required error' do
      post '/api/graphql', params: { query: query }

      expect(response.status).to eq 200
      expect(data).to be_nil
      expect(error['message']).to eq 'Invalid Authroization Token'
    end
  end

  context 'with invalid token' do
    let(:token) { 'invalid' }

    it 'returns invalid token error' do
      post '/api/graphql', params: { query: query }, headers: headers

      expect(response.status).to eq 200
      expect(data).to be_nil
      expect(error['message']).to eq 'Not enough or too many segments'
    end
  end

  context 'with expried token' do
    let(:token) { JWT.encode({ 'user_id' => user.id, exp: 10.minutes.ago.to_i }, secret) }

    it 'returns invalid token error' do
      post '/api/graphql', params: { query: query }, headers: { 'Authorization' => "Bearer #{token}" }

      expect(response.status).to eq 200
      expect(data).to be_nil
      expect(error['message']).to eq 'Signature has expired'
    end
  end

  context 'with invalid user_id' do
    let(:id)    { rand(9999) }
    let(:token) { JWT.encode({ 'user_id' => id }, secret) }

    it 'returns user not found error' do
      post '/api/graphql', params: { query: query }, headers: headers

      expect(response.status).to eq 200
      expect(data).to be_nil
      expect(error.size).to eq 1
      expect(error['message']).to eq "Couldn't find User with 'id'=#{id}"
    end
  end
end
