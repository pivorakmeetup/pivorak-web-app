module Admin
  class VisitRequest
    class ToggleVisitController < VisitRequest::BaseController
      def update
        ::VisitRequest::CheckIn.new(visit_request).call
        ::VisitRequest::ToggleVisit.call(visit_request)

        ::VisitRequest::RealTimeUpdate.call(visit_request)
        head :ok
      end
    end
  end
end
