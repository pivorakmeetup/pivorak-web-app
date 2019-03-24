# frozen_string_literal: true

require 'rails_helper'

describe Event::ExportToIcal do
  subject { described_class }

  describe '#call' do
    let(:event) do
      build(:event,
            started_at:  '2017-03-24 18:00',
            finished_at: '2017-03-24 22:00',
            title:       '#pivorak 21: Elixir edition about Nerves, Docker & Flowex',
            description: '#pivorak is happy to be back with Elixir Edition!')
    end

    let(:icalendar_file) { subject.call(event) }

    it 'renders the start time' do
      expect(icalendar_file).to include('DTSTART:20170324T180000')
    end

    it 'renders the finish time' do
      expect(icalendar_file).to include('DTEND:20170324T220000')
    end

    it 'renders the title' do
      expect(icalendar_file)
        .to include('SUMMARY:#pivorak 21: Elixir edition about Nerves\, Docker & Flowex')
    end

    it 'renders the description' do
      expect(icalendar_file)
        .to include('DESCRIPTION:#pivorak is happy to be back with Elixir Edition!')
    end

    it 'renders the organizer' do
      expect(icalendar_file).to include('ORGANIZER;CN=#pivorak Lviv Ruby MeetUp')
    end
  end
end
