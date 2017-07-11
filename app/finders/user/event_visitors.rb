class User
  class EventVisitors < ApplicationFinder
    def initialize(event_id:)
      @event_id = event_id
    end

    def call
      User.joins(:visit_requests)
        .where(visit_requests: { event_id: event_id, visited: true })
    end

    private

    attr_reader :event_id
  end
end
