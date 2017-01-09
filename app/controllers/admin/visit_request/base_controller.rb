module Admin
  class VisitRequest
    class BaseController < Admin::BaseController
      private

      def default_redirect
        redirect_to admin_event_visit_requests_path(event)
      end

      def visit_request
        @visit_request ||= ::VisitRequest.find(params[:visit_request_id])
      end

      def event
        @event ||= ::Event.friendly.find(params[:event_id])
      end
    end
  end
end
