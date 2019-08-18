# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GraphqQL Api Events query' do
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
          }
        }
      }
    GQL
  end

  let(:result)  { Api::Schema.execute(query, context: context) }
  let(:user)    { build_stubbed(:user) }
  let(:context) { { current_user: user } }

  let!(:event_a) { create(:event) }
  let!(:event_b) { create(:event) }
  let!(:event_c) { create(:event, status: :planned) }

  let!(:talk_a1) { create(:talk, event: event_a) }
  let!(:talk_a2) { create(:talk, event: event_a) }
  let!(:talk_b1) { create(:talk, event: event_b) }

  it 'returns member info' do
    expect(result['data']['events'].size).to              eq 2

    expect(result['data']['events'][0]['id']).to          eq event_a.id.to_s
    expect(result['data']['events'][0]['title']).to       eq event_a.title
    expect(result['data']['events'][0]['description']).to eq event_a.description
    expect(result['data']['events'][0]['agenda']).to      eq event_a.agenda
    expect(result['data']['events'][0]['status']).to      eq event_a.status

    expect(result['data']['events'][0]['talks'].size).to  eq 2

    [talk_a1, talk_a2].each do |talk|
      expect(result['data']['events'][0]['talks']).to include(
        hash_including(
          'id'          => talk.id.to_s,
          'description' => talk.description,
          'videoUrl'    => talk.video_url,
          'slidesUrl'   => talk.slides_url
        )
      )
    end

    expect(result['data']['events'][1]['id']).to          eq event_b.id.to_s
    expect(result['data']['events'][1]['title']).to       eq event_b.title
    expect(result['data']['events'][1]['description']).to eq event_b.description
    expect(result['data']['events'][1]['agenda']).to      eq event_b.agenda
    expect(result['data']['events'][1]['status']).to      eq event_b.status

    expect(result['data']['events'][1]['talks'].size).to  eq 1

    expect(result['data']['events'][1]['talks'][0]['id']).to          eq talk_b1.id.to_s
    expect(result['data']['events'][1]['talks'][0]['title']).to       eq talk_b1.title
    expect(result['data']['events'][1]['talks'][0]['description']).to eq talk_b1.description
    expect(result['data']['events'][1]['talks'][0]['videoUrl']).to    eq talk_b1.video_url
    expect(result['data']['events'][1]['talks'][0]['slidesUrl']).to   eq talk_b1.slides_url
  end
end
