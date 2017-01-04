class VisitRequest
  class Attend < ApplicationService
    def initialize(user, event)
      @user  = user
      @event = event
    end

    def call
      if user.verified? && event.has_free_verified_slots?
        visit_request.approved!
      else
        visit_request.pending!
      end
    end

    private

    attr_reader :user, :event

    def visit_request
      @visit_request ||= VisitRequest.find_or_initialize_by(
        user: user, event: event
      )
    end
  end
end
