class VisitRequest
  class Create < ApplicationService
    def initialize(user, event)
      @user  = user
      @event = event
    end

    def call
      if user.verified? && policy.has_free_slot_for?(user)
        return VisitRequest::Approve.call(visit_request)
      end

      unless user.verified?
        VisitRequestMailer.needs_confirmation(visit_request).deliver_later
      end

      visit_request.pending!
      visit_request.waiting_list! unless policy.has_free_slot_for?(user)
    end

    private

    attr_reader :user, :event

    def visit_request
      @visit_request ||= VisitRequest.find_or_create_by(
        user: user, event: event
      )
    end

    def policy
      @policy ||= Event::SlotsPolicy.new(event)
    end
  end
end
