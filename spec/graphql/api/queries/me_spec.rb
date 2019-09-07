require 'rails_helper'

RSpec.describe Api::Queries::Me do
  let(:result) { Api::Schema.execute(query, context: context) }

  let(:query) do
    <<~GQL
      {
        me {
          id
          email
          firstName
          lastName
          visits {
            id
            status
            event {
              title
            }
          }
        }
      }
    GQL
  end

  let(:context) { { current_user: user } }
  let(:user) { build_stubbed(:user) }

  it 'returns user data' do
    expect(result['data']['me']['id']).to eq user.id.to_s
    expect(result['data']['me']['email']).to eq user.email
    expect(result['data']['me']['firstName']).to eq user.first_name
    expect(result['data']['me']['lastName']).to eq user.last_name
  end
end
