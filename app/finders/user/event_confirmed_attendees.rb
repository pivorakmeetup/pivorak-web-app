# frozen_string_literal: true

class User
  class EventConfirmedAttendees < ApplicationFinder
    def initialize(params = {})
      @event_id = params[:event_id]
    end

    def call
      User.joins(:visit_requests)
          .where(visit_requests: { event_id: event_id })
          .where(visit_requests: { id: VisitRequest.confirmed_attendees })
    end

    private

    attr_reader :event_id
  end
end
