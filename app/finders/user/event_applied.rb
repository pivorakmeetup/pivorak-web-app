class User
  class EventApplied < ApplicationFinder
    def initialize(params = {})
      @event_id = params[:event_id]
    end

    def call
      User.joins(:visit_requests).where(visit_requests: { event_id: event_id })
    end

    private

    attr_reader :event_id
  end
end
