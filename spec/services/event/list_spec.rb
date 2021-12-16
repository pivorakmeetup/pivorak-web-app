# frozen_string_literal: true

require 'rails_helper'

describe Event::List do
  subject { described_class }

  describe '#call' do
    let!(:recent_event) { create(:event, started_at: Time.current + 2.months) }
    let!(:events) { create_list(:event, 5) }

    let(:list) { subject.call(events: Event.all) }

    it 'takes sorted list of events' do
      expect(list.first).to eq recent_event
    end
  end
end
