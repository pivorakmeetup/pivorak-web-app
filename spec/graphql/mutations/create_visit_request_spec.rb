# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GraphqQL Api CreateVisitRequest mutation' do
  let(:result)    { Api::Schema.execute(query, context: context, variables: variables) }
  let(:user)      { create(:user) }
  let(:context)   { { current_user: user } }
  let(:variables) { { eventId: event_id } }
  let(:event_id)  { event.id }
  let(:event)     { create(:event, status: :registration, limit_verified: 1, limit_total: 1) }

  let(:query) do
    <<~GQL
      mutation($eventId: ID!) {
        createVisitRequest(eventId: $eventId) {
          id
          status
          event {
            id
          }
        }
      }
    GQL
  end

  context 'non verified member' do
    it 'returns created pending visit request for given event' do
      expect(result['data']['createVisitRequest']['id']).to be_present
      expect(result['data']['createVisitRequest']['status']).to eq 'PENDING'
      expect(result['data']['createVisitRequest']['event']['id']).to eq event_id.to_s
    end
  end

  context 'verified member' do
    before { user.update(verified: true) }

    it 'returns created approved visit request for given event' do
      expect(result['data']['createVisitRequest']['id']).to be_present
      expect(result['data']['createVisitRequest']['status']).to eq 'APPROVED'
      expect(result['data']['createVisitRequest']['event']['id']).to eq event_id.to_s
    end
  end

  context 'invalid event status' do
    before { event.live! }

    it 'raise exception' do
      expect { result }.to raise_error ActiveRecord::RecordNotFound
    end
  end
end
