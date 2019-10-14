# frozen_string_literal: true

module Admin
  class VisitRequest
    class ApproveController < VisitRequest::BaseController
      def update
        ::VisitRequest::Approve.call(visit_request)

        ::VisitRequest::RealTimeUpdate.call(visit_request)
        head :ok
      end
    end
  end
end
