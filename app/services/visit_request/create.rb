class VisitRequest
  class Create < ApplicationService
    def initialize(user, event)
      @user  = user
      @event = event
    end

    def call
      return visit_request.approved! if user.verified? && event.has_free_slot_for?(user)

      visit_request.pending! unless user.verified? && event.has_free_slot_for?(user)
      visit_request.waiting_list! unless event.has_free_slot_for?(user)
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
