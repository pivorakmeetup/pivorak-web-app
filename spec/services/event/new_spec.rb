require 'rails_helper'

describe Event::New do
  subject { described_class }

  describe '#call' do
    let (:new_event) { subject.call }

    it 'should have default started_at hour' do
      expect(new_event.started_at.hour).to eq(Event::DEFAULT_STARTED_AT_HOURS)
    end

    it 'should have default finished_at hour' do
      expect(new_event.finished_at.hour).to eq(Event::DEFAULT_FINISHED_AT_HOURS)
    end
  end
end
