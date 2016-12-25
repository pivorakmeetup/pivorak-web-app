module Admin
  module VisitRequest
    class CancelController < ::VisitRequest::BaseController
      def update
        ::VisitRequest::Cancel.call(visit_request)
        redirect_to admin_event_visit_requests_path(event)
      end

      private

      def visit_request
        @visit_request ||= ::VisitRequest.find(params[:visit_request_id])
      end
    end
  end
end
