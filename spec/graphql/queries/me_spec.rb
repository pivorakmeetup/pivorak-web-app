# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GraphqQL Api Me query' do
  let(:query) do
    <<~GQL
      {
        me {
          id
          email
          firstName
          lastName
          verified
        }
      }
    GQL
  end

  let(:result)  { Api::Schema.execute(query, context: context) }
  let(:user)    { build_stubbed(:user) }
  let(:context) { { current_user: user } }

  it 'returns member info' do
    expect(result['data']['me']['id']).to        eq user.id.to_s
    expect(result['data']['me']['email']).to     eq user.email
    expect(result['data']['me']['firstName']).to eq user.first_name
    expect(result['data']['me']['lastName']).to  eq user.last_name
    expect(result['data']['me']['verified']).to  eq user.verified
  end
end
