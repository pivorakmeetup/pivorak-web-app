module Admin
  class VisitRequest
    class ToggleVisitController < VisitRequest::BaseController
      def update
        ::VisitRequest::ToggleVisit.call(visit_request)

        ::VisitRequest::RealTimeUpdate.call(visit_request)
        head :ok
      end
    end
  end
end
