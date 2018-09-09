require 'rails_helper'

describe Event::List do
  subject { described_class }

  describe '#call' do
    let!(:recent_event) { FactoryBot.create(:event, started_at: Time.zone.now + 2.months) }
    let!(:events) { 5.times.map { FactoryBot.create(:event) } }

    let(:list) { subject.(events: Event.all) }

    it 'takes sorted list of events' do
      expect(list.first).to eq recent_event
    end
  end
end
