# frozen_string_literal: true

class User
  class EventAttendeesWithoutRefusedAndCanceled < ApplicationFinder
    def initialize(params = {})
      @event_id = params[:event_id]
    end

    def call
      User.joins(:visit_requests)
          .where(visit_requests: { event_id: event_id })
          .where(visit_requests: { id: VisitRequest.without_refused_and_canceled })
    end

    private

    attr_reader :event_id
  end
end
