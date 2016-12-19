module Admin
  module VisitRequest
    class VisitRequestsController < BaseController
      helper_method :visit_requests, :event

      def index
      end

      private

      def visit_requests
        @visit_requests ||= event.visit_requests.includes(:user)
      end

      def event
        @event ||= Event.friendly.find(params[:event_id])
      end
    end
  end
end
