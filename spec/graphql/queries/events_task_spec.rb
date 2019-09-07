# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GraphqQL Api Events query' do
  let(:result)    { Api::Schema.execute(query, context: context, variables: variables) }
  let(:user)      { build_stubbed(:user) }
  let(:context)   { { current_user: user } }

  let(:variables) { { filter: { status: status, venueIds: venue_ids } } }
  let(:venue_ids) { [venue_b.id] }
  let(:status)    { 'PASSED' }

  context 'all events' do
    let(:query) do
      <<~GQL
        query Events($filter: EventFilter) {
          events(filter: $filter) {
            id
            title
            venue {
              name
            }
          }
        }
      GQL
    end

    let!(:venue_a) { create(:venue) }
    let!(:venue_b) { create(:venue) }
    let!(:venue_c) { create(:venue) }

    context 'events filter by venues' do
      context 'when there is one event in one venue' do
        let!(:event_a) { create(:event, status: :passed,  venue_id: venue_a.id) }
        let!(:event_b) { create(:event, status: :passed,  venue_id: venue_b.id) }
        let!(:event_c) { create(:event, status: :planned, venue_id: venue_c.id) }

        it 'returns lits of passed events with title and venues' do
          expect(result['data']['events'].size).to                eq 1
          expect(result['data']['events'][0]['id']).to            eq event_b.id.to_s
          expect(result['data']['events'][0]['title']).to         eq event_b.title
          expect(result['data']['events'][0]['venue']['name']).to eq event_b.venue.name
        end
      end

      context 'when there is two events in one venue' do
        let!(:event_a) { create(:event, status: :passed,  venue_id: venue_b.id) }
        let!(:event_b) { create(:event, status: :passed,  venue_id: venue_b.id) }
        let!(:event_c) { create(:event, status: :planned, venue_id: venue_c.id) }

        it 'returns lits of passed events with title and venues' do
          expect(result['data']['events'].size).to                eq 2
          expect(result['data']['events'][0]['id']).to            eq event_b.id.to_s
          expect(result['data']['events'][0]['title']).to         eq event_b.title
          expect(result['data']['events'][0]['venue']['name']).to eq event_b.venue.name
        end
      end

      context 'when there is two events in two venues' do
        let!(:event_a) { create(:event, status: :passed,  venue_id: venue_a.id) }
        let!(:event_b) { create(:event, status: :passed,  venue_id: venue_b.id) }
        let!(:event_c) { create(:event, status: :planned, venue_id: venue_c.id) }

        let(:venue_ids) { [venue_b.id, venue_a.id] }

        it 'returns lits of passed events with title and venues' do
          expect(result['data']['events'].size).to                eq 2

          expect(result['data']['events'][0]['id']).to            eq event_b.id.to_s
          expect(result['data']['events'][0]['title']).to         eq event_b.title
          expect(result['data']['events'][0]['venue']['name']).to eq event_b.venue.name

          expect(result['data']['events'][1]['id']).to            eq event_a.id.to_s
          expect(result['data']['events'][1]['title']).to         eq event_a.title
          expect(result['data']['events'][1]['venue']['name']).to eq event_a.venue.name
        end
      end
    end
  end
end
