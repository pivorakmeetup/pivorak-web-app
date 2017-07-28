module Admin
  class VisitRequest
    class CancelController < VisitRequest::BaseController
      def update
        ::VisitRequest::Cancel.call(visit_request)

        ::VisitRequest::RealTimeUpdate.call(visit_request)
        head :ok
      end
    end
  end
end
