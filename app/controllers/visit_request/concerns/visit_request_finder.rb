class VisitRequest
  module Concerns
    module VisitRequestFinder
      def visit_request
        @visit_request ||= ::VisitRequest.find(params[:visit_request_id])
      end
    end
  end
end
