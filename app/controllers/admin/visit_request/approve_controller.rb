module Admin
  module VisitRequest
    class ApproveController < BaseController
      def update
        ::VisitRequest::Approve.call(visit_request)
        redirect_to admin_event_visit_requests_path(event)
      end

      private

      def event
        @event ||= Event.friendly.find(params[:event_id])
      end

      def visit_request
        @visit_request ||= ::VisitRequest.find(params[:visit_request_id])
      end
    end
  end
end
