class Event
  class SendConfirmationReminders < ApplicationService
    EMAILS_BULK_SIZE = 100

    def initialize(event)
      @event = event
    end

    def call
      event.visit_requests.approved.each_slice(EMAILS_BULK_SIZE).with_index do |visit_requests, index|
        visit_requests.each do |visit_request|
          VisitRequestMailer.confirmation_reminder(visit_request).deliver_later(wait: index.hour)
        end
      end
    end

    private

    attr_reader :event
  end
end
