# frozen_string_literal: true

class Event
  class SendConfirmationReminders < ApplicationService
    def initialize(event)
      @event = event
    end

    def call
      BulkEmailSender.call(
        mailer_klass: VisitRequestMailer, method_name: :confirmation_reminder, scope: event.visit_requests.approved
      )
    end

    private

    attr_reader :event
  end
end
