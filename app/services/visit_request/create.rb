# frozen_string_literal: true

class VisitRequest
  class Create < ApplicationService
    def initialize(user, event)
      @user  = user
      @event = event
    end

    def call # rubocop:disable Metrics/AbcSize
      return VisitRequest::Approve.call(visit_request) if user.verified? && policy.free_slot_for?(user)

      VisitRequestMailer.needs_confirmation(visit_request).deliver_later unless user.verified?
      visit_request.pending!
      visit_request.waiting_list! unless policy.free_slot_for?(user)

      visit_request
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
