module Admin
  class VisitRequest
    class ToggleVisitController < VisitRequest::BaseController
      def update
        ::VisitRequest::ToggleVisit.call(visit_request)

        default_redirect
      end
    end
  end
end
