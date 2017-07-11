class Event
  class Visitors < ApplicationFinder
    def call
      Event.joins(:visit_requests).where(visit_requests: { visited: true } )
    end
  end
end
