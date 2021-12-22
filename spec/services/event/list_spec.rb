# frozen_string_literal: true

require 'rails_helper'

describe Event::List do
  describe '#call' do
    let!(:recent_event) { create(:event, started_at: Time.current + 2.months) }
    let(:list) { described_class.call(events: Event.all) }

    before do
      create_list(:event, 5)
    end

    it 'takes sorted list of events' do
      expect(list.first).to eq recent_event
    end
  end
end
