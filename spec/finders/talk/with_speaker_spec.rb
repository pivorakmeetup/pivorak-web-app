require 'rails_helper'

describe Talk::WithSpeaker do
  let(:event) { create :event_with_talks, talks_count: 4 }

  subject(:result) { described_class.call(event.id) }

  it 'finds talks for event_id' do
    expect(result).to eq event.talks.sort
  end
end
