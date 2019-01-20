class Event
  class SendConfirmations < ApplicationService
    def initialize(event)
      @event = event
    end

    def call
      event.visit_requests.final.each_with_index do |visit_request, index|
        VisitRequestMailer.confirmation(visit_request).deliver_later(wait: index.minute)
      end
    end

    private

    attr_reader :event
  end
end
