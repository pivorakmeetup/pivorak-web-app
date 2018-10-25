class Event
  class SendConfirmationReminders < ApplicationService
    def initialize(event)
      @event = event
    end

    def call
      event.visit_requests.approved.each do |visit_request|
        VisitRequestMailer.confirmation_reminder(visit_request).deliver_later
      end
    end

    private

    attr_reader :event
  end
end
