class Event
  class New < ApplicationService
    def call
      Event.new(
        started_at: date_with_specified_hour(Event::DEFAULT_STARTED_AT_HOURS),
        finished_at: date_with_specified_hour(Event::DEFAULT_FINISHED_AT_HOURS)
      )
    end

    private

    def date_with_specified_hour(hour)
      Time.zone.now.change(hour: hour)
    end

  end
end
