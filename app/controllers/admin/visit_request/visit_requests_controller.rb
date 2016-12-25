module Admin
  module VisitRequest
    class VisitRequestsController < ::VisitRequest::BaseController
      helper_method :visit_requests, :event

      def index
      end

      private

      def visit_requests
        @visit_requests ||= event.visit_requests.includes(:user)
      end
    end
  end
end
