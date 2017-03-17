class Event
  class ExportToIcal < ApplicationService
    def initialize(event)
      @event = event
    end

    def call
      calendar = Icalendar::Calendar.new
      calendar.event do |e|
        e.dtstart     = Icalendar::Values::DateTime.new(event.started_at)
        e.dtend       = Icalendar::Values::DateTime.new(event.finished_at)
        e.summary     = event.title
        e.description = event.description
        e.ip_class    = 'PRIVATE'
        e.organizer   = Icalendar::Values::CalAddress.new(
          "mailto:#{ApplicationMailer::PIVORAK_EMAIL}",
          cn: '#pivorak Lviv Ruby MeetUp'
        )
      end

      calendar.publish
      calendar.to_ical
    end

    private

    attr_reader :event
  end
end

