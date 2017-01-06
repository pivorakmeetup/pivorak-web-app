module Admin
  class VisitRequest
    class CancelController < VisitRequest::BaseController
      def update
        ::VisitRequest::Cancel.call(visit_request)

        default_redirect
      end
    end
  end
end
