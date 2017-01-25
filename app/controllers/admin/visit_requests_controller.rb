module Admin
  class VisitRequestsController < ::Admin::BaseController
    helper_method :visit_requests, :event

    def index
      add_breadcrumb 'events.plural', path: :admin_events_path
      add_breadcrumb event, path: edit_admin_event_path(event)
      add_breadcrumb 'visit_requests.plural'
    end

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
