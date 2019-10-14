# frozen_string_literal: true

class Event
  class PerEventVisitors < ApplicationFinder
    def call
      Event.joins(:visit_requests)
           .where(visit_requests: { visited: true })
           .group('events.finished_at, events.title')
           .order('events.finished_at')
    end
  end
end
