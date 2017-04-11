module Profiling::User
  class EventAttendees < ApplicationFinder
    def initialize(params = {})
      @event_id = params[:event_id]
    end

    def call
      Profiling::User.joins(:visit_requests)
        .where(visit_requests: { event_id: event_id })
        .where(visit_requests: { id: VisitRequest.final })
    end

    private

    attr_reader :event_id
  end
end
