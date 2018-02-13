class User
  class EventParticipantsByStatus < ApplicationFinder
    def initialize(params = {})
      @event_id = params[:event_id]
      @status = params[:status]
    end

    def call
      User.joins(:visit_requests).where(visit_requests: { event_id: event_id, status: status })
    end

    private

    attr_reader :event_id, :status
  end
end
