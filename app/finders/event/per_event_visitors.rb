class Event
  class PerEventVisitors < ApplicationFinder
    def call
      Event.joins(:visit_requests)
        .where(visit_requests: { visited: true } )
        .group('events.title')
    end
  end
end
