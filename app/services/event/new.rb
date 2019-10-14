# frozen_string_literal: true

class Event
  class New < ApplicationService
    def call
      Event.new(
        started_at:  date_with_specified_hour(Ez::Settings[:app, :events, :default_started_at_hours]),
        finished_at: date_with_specified_hour(Ez::Settings[:app, :events, :default_finished_at_hours])
      )
    end

    private

    def date_with_specified_hour(hour)
      Time.zone.now.change(hour: hour)
    end
  end
end
