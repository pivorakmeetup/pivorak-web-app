# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GraphqQL Api Events query' do
  let(:result)    { Api::Schema.execute(query, context: context, variables: variables) }
  let(:user)      { build_stubbed(:user) }
  let(:context)   { { current_user: user } }
  let(:variables) { {} }

  context 'all events' do
    let(:query) do
      <<~GQL
        {
          events {
            id
            title
            description
            agenda
            startedAt
            status
            talks {
              id
              title
              description
              videoUrl
              slidesUrl
              speaker {
                id
                firstName
                lastName
              }
            }
          }
        }
      GQL
    end

    let!(:event_a) { create(:event, started_at: Time.current) }
    let!(:event_b) { create(:event, started_at: 10.days.ago) }
    let!(:event_c) { create(:event, status: :planned) }

    let!(:talk_a1) { create(:talk, event: event_a, speaker: speaker_a) }
    let!(:talk_a2) { create(:talk, event: event_a, speaker: speaker_b) }
    let!(:talk_b1) { create(:talk, event: event_b, speaker: speaker_c) }

    let(:speaker_a) { create(:user) }
    let(:speaker_b) { create(:user) }
    let(:speaker_c) { create(:user) }

    it 'returns lits of active events with talks and speakers' do
      expect(result['data']['events'].size).to              eq 2

      expect(result['data']['events'][0]['id']).to          eq event_a.id.to_s
      expect(result['data']['events'][0]['title']).to       eq event_a.title
      expect(result['data']['events'][0]['description']).to eq event_a.description
      expect(result['data']['events'][0]['agenda']).to      eq event_a.agenda
      expect(result['data']['events'][0]['status']).to      eq event_a.status.upcase

      expect(result['data']['events'][0]['talks'].size).to  eq 2

      [talk_a1, talk_a2].each do |talk|
        expect(result['data']['events'][0]['talks']).to include(
          hash_including(
            'id'          => talk.id.to_s,
            'title'       => talk.title,
            'description' => talk.description,
            'videoUrl'    => talk.video_url,
            'slidesUrl'   => talk.slides_url,
            'speaker'     => hash_including(
              'id'        => talk.speaker.id.to_s,
              'firstName' => talk.speaker.first_name,
              'lastName'  => talk.speaker.last_name
            )
          )
        )
      end

      expect(result['data']['events'][1]['id']).to          eq event_b.id.to_s
      expect(result['data']['events'][1]['title']).to       eq event_b.title
      expect(result['data']['events'][1]['description']).to eq event_b.description
      expect(result['data']['events'][1]['agenda']).to      eq event_b.agenda
      expect(result['data']['events'][1]['status']).to      eq event_b.status.upcase

      expect(result['data']['events'][1]['talks'].size).to  eq 1

      expect(result['data']['events'][1]['talks'][0]['id']).to          eq talk_b1.id.to_s
      expect(result['data']['events'][1]['talks'][0]['title']).to       eq talk_b1.title
      expect(result['data']['events'][1]['talks'][0]['description']).to eq talk_b1.description
      expect(result['data']['events'][1]['talks'][0]['videoUrl']).to    eq talk_b1.video_url
      expect(result['data']['events'][1]['talks'][0]['slidesUrl']).to   eq talk_b1.slides_url

      expect(result['data']['events'][1]['talks'][0]['speaker']['id']).to        eq speaker_c.id.to_s
      expect(result['data']['events'][1]['talks'][0]['speaker']['firstName']).to eq speaker_c.first_name
      expect(result['data']['events'][1]['talks'][0]['speaker']['lastName']).to  eq speaker_c.last_name
    end
  end

  context 'paginated events and talks' do
    let(:query) do
      <<~GQL
        query Events($eventPagination: Pagination, $talksPagination: Pagination) {
          events(pagination: $eventPagination) {
            id
            talks(pagination: $talksPagination) {
              id
            }
          }
        }
      GQL
    end

    let(:variables) do
      {
        eventPagination: { limit: 1, offset: 1 },
        talksPagination: { limit: 1, offset: 1 }
      }
    end

    let!(:event_a) { create(:event) }
    let!(:event_b) { create(:event) }
    let!(:event_c) { create(:event) }
    let!(:talk_b1) { create(:talk, event: event_b) }
    let!(:talk_b2) { create(:talk, event: event_b) }
    let!(:talk_b3) { create(:talk, event: event_b) }

    it 'returns lits of active events with talks and speakers' do
      expect(result['data']['events'].size).to eq 1
      expect(result['data']['events'][0]['id']).to eq event_b.id.to_s

      expect(result['data']['events'][0]['talks'].size).to eq 1
      expect(result['data']['events'][0]['talks'][0]['id']).to eq talk_b2.id.to_s
    end
  end

  context 'filter events' do
    let(:query) do
      <<~GQL
        query Events($filter: EventFilter) {
          events(filter: $filter) {
            id
            title
          }
        }
      GQL
    end

    context 'by single status' do
      let(:variables) do
        {
          filter: { status: ['REGISTRATION'] }
        }
      end

      let!(:event_a) { create(:event, status: :registration) }
      let!(:event_b) { create(:event, status: :confirmation) }

      it 'returns lits of active events with talks and speakers' do
        puts result.inspect

        expect(result['data']['events'].size).to eq 1
        expect(result['data']['events'][0]['id']).to eq event_a.id.to_s
      end
    end

    context 'by multiple statuses' do
      let(:variables) do
        {
          filter: { status: %w[REGISTRATION LIVE] }
        }
      end

      let!(:event_a) { create(:event, status: :registration) }
      let!(:event_b) { create(:event, status: :confirmation) }
      let!(:event_c) { create(:event, status: :live) }

      it 'returns lits of active events with talks and speakers' do
        puts result.inspect

        expect(result['data']['events'].size).to eq 2
        expect(result['data']['events'][0]['id']).to eq event_c.id.to_s
        expect(result['data']['events'][1]['id']).to eq event_a.id.to_s
      end
    end

    context 'by date range' do
      let(:start_date) { 2.hours.ago.iso8601 }

      let(:variables) do
        {
          filter: { startAt: { from: start_date.to_s } }
        }
      end

      let!(:event_a) { create(:event, status: :registration, started_at: 1.day.ago) }
      let!(:event_b) { create(:event, status: :confirmation, started_at: 1.week.ago) }
      let!(:event_c) { create(:event, status: :live, started_at: 1.hour.ago) }

      it 'returns lits of events started 2 hours ago' do
        expect(result['data']['events'].size).to eq 1
      end
    end
  end
end
