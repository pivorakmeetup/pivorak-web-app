class Event
  class PerEventVisitors < ApplicationFinder
    def call
      Event.joins(:visit_requests)
        .where(visit_requests: { status: ::VisitRequest::CONFIRMED})
        .group('events.title')
    end
  end
end
