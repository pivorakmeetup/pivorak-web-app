# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GraphqQL Api Me query' do
  let(:result)    { Api::Schema.execute(query, context: context, variables: variables) }
  let(:user)      { build_stubbed(:user) }
  let(:context)   { { current_user: user } }
  let(:variables) { {} }

  context 'profile with all visits' do
    let(:query) do
      <<~GQL
        {
          me {
            id
            email
            firstName
            lastName
            verified
            visits {
              id
              status
              waitingList
              visited
              checkedInAt
              event {
                id
              }
            }
          }
        }
      GQL
    end

    let!(:visit_a) { create(:visit_request, user: user) }
    let!(:visit_b) { create(:visit_request, user: user) }

    it 'returns member with visits' do
      expect(result['data']['me']['id']).to        eq user.id.to_s
      expect(result['data']['me']['email']).to     eq user.email
      expect(result['data']['me']['firstName']).to eq user.first_name
      expect(result['data']['me']['lastName']).to  eq user.last_name
      expect(result['data']['me']['verified']).to  eq user.verified

      expect(result['data']['me']['visits'].size).to eq 2

      [visit_a, visit_b].each do |visit|
        expect(result['data']['me']['visits']).to include(
          hash_including(
            'id'          => visit.id.to_s,
            'status'      => visit.status.upcase,
            'waitingList' => visit.waiting_list,
            'visited'     => visit.visited,
            'checkedInAt' => visit.checked_in_at,
            'event'       => hash_including(
              'id' => visit.event.id.to_s
            )
          )
        )
      end
    end
  end

  context 'paginated visits' do
    let(:query) do
      <<~GQL
        query Me($pagination: Pagination) {
          me {
            id
            visits(pagination: $pagination) {
              id
            }
          }
        }
      GQL
    end

    let(:variables) { { pagination: { limit: 1, offset: 1 } } }

    let!(:visit_a) { create(:visit_request, user: user) }
    let!(:visit_b) { create(:visit_request, user: user) }
    let!(:visit_c) { create(:visit_request, user: user) }

    it 'returns member id with paginated visits' do
      expect(result['data']['me']['id']).to eq user.id.to_s

      expect(result['data']['me']['visits'].size).to eq 1
      expect(result['data']['me']['visits'][0]['id']).to eq visit_b.id.to_s
    end
  end
end
