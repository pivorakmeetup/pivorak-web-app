module Admin
  class VisitRequest
    class SendConfirmationsController < VisitRequest::BaseController
      def create
        Event::SendConfirmations.call(event)

        default_redirect
      end
    end
  end
end
