class Event
  class SendConfirmationReminders < ApplicationService
    def initialize(event)
      @event = event
    end

    def call
      event.visit_requests.approved.each_with_index do |visit_request, index|
        VisitRequestMailer.confirmation_reminder(visit_request).deliver_later(wait: index.minute)
      end
    end

    private

    attr_reader :event
  end
end
