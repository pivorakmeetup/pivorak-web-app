module Admin
  class VisitRequestsController < ::Admin::BaseController
    helper_method :visit_requests, :event

    private

    def event
      @event ||= Event.friendly.find(params[:event_id])
    end

    def visit_requests
      scoped = event.live? ? event.visit_requests.final : event.visit_requests

      @visit_requests ||= scoped.includes(:user, :event).order(:id)
    end
  end
end
