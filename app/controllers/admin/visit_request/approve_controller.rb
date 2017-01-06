module Admin
  class VisitRequest
    class ApproveController < VisitRequest::BaseController
      def update
        ::VisitRequest::Approve.call(visit_request)

        default_redirect
      end
    end
  end
end
