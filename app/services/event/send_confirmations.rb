class Event
  class SendConfirmations < ApplicationService
    def initialize(event)
      @event = event
    end

    def call
      BulkEmailSender.call(mailer_klass: VisitRequestMailer, method_name: :confirmation, scope: event.visit_requests.final)
    end

    private

    attr_reader :event
  end
end
