class VisitRequest
  class Create < ApplicationService
    def initialize(user_id, event)
      @user_id = user_id
      @event   = event
    end

    def call
      return visit_request.approved! if user.verified? && policy.has_free_slot_for?(user_id)
      VisitRequestMailer.unverified_attendee(visit_request.id).deliver_later unless user.verified?
      visit_request.pending!
      visit_request.waiting_list! unless policy.has_free_slot_for?(user_id)
    end

    private

    attr_reader :user_id, :event

    def user
      @user ||= User.find(user_id)
    end

    def visit_request
      @visit_request ||= VisitRequest.find_or_initialize_by(
        user_id: user_id, event: event
      )
    end

    def policy
      @policy ||= Event::SlotsPolicy.new(event)
    end
  end
end
