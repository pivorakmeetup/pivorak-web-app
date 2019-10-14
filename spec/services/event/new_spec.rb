# frozen_string_literal: true

require 'rails_helper'

describe Event::New do
  subject { described_class }

  describe '#call' do
    let(:new_event) { subject.call }

    it 'should have default started_at hour' do
      expect(new_event.started_at.hour).to eq(Ez::Settings[:app, :events, :default_started_at_hours].to_i)
    end

    it 'should have default finished_at hour' do
      expect(new_event.finished_at.hour).to eq(Ez::Settings[:app, :events, :default_finished_at_hours].to_i)
    end
  end
end
