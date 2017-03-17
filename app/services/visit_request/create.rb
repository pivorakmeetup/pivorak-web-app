class VisitRequest
  class Create < ApplicationService
    def initialize(user, event)
      @user  = user
      @event = event
    end

    def call
      return visit_request.approved! if user.verified? && policy.has_free_slot_for?(user)
      VisitRequestMailer.unverified_attendee(visit_request.id).deliver_later unless user.verified?
      visit_request.pending!
      visit_request.waiting_list! unless policy.has_free_slot_for?(user)
    end

    private

    attr_reader :user, :event

    def visit_request
      @visit_request ||= VisitRequest.find_or_initialize_by(
        user: user, event: event
      )
    end

    def policy
      @policy ||= Event::SlotsPolicy.new(event)
    end
  end
end
