module Admin
  module VisitRequest
    class CancelController < ::VisitRequest::BaseController
      def update
        ::VisitRequest::Cancel.call(visit_request)
        redirect_to admin_event_visit_requests_path(event)
      end
    end
  end
end
