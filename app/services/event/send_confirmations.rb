class Event
  class SendConfirmations < ApplicationService
    EMAILS_BULK_SIZE = 100

    def initialize(event)
      @event = event
    end

    def call
      event.visit_requests.final.each_slice(EMAILS_BULK_SIZE).with_index do |visit_requests, index|
        visit_requests.each do |visit_request|
          VisitRequestMailer.confirmation(visit_request).deliver_later(wait: index.hour)
        end
      end
    end

    private

    attr_reader :event
  end
end
