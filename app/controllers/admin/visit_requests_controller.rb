module Admin
  class VisitRequestsController < ::Admin::BaseController
    helper_method :visit_requests, :event

    private

    def event
      @event ||= Event.friendly.find(params[:event_id])
    end

    def visit_requests
      @visit_requests ||= event.visit_requests.includes(:user)
    end
  end
end
