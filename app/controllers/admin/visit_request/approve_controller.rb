module Admin
  module VisitRequest
    class ApproveController < ::VisitRequest::BaseController
      def update
        ::VisitRequest::Approve.call(visit_request)
        redirect_to admin_event_visit_requests_path(event)
      end
    end
  end
end
