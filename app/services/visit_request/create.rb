class VisitRequest
  class Create < ApplicationService
    def initialize(user, event)
      @user  = user
      @event = event
    end

    def call
      return visit_request.approved! if user.verified? && policy.has_free_slot_for?(user)

      unless user.verified? && policy.has_free_slot_for?(user)
        visit_request.pending!
        VisitRequestMailer.unverified_attendee(visit_request.id).deliver_later
      end

      visit_request.waiting_list! unless policy.has_free_slot_for?(user)
    end

    private

    attr_reader :user, :event, :policy

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
