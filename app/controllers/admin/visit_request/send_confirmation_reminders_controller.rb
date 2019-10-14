# frozen_string_literal: true

module Admin
  class VisitRequest
    class SendConfirmationRemindersController < VisitRequest::BaseController
      def create
        Event::SendConfirmationReminders.call(event)

        default_redirect
      end
    end
  end
end
