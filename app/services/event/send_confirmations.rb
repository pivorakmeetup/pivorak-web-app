class Event
  class SendConfirmations < ApplicationService
    def initialize(event)
      @event = event
    end

    def call
      event.visit_requests.final.each do |visit_request|
        VisitRequestMailer.confirmation(visit_request).deliver_later
      end
    end

    private

    attr_reader :event
  end
end
