module Admin
  class VisitRequestsController < ::Admin::BaseController
    helper_method :visit_requests, :event, :visitors_ids

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
      @visit_requests ||= search_against(base_scope).includes(:user).order(:id)
    end

    def base_scope
      event.send(event.live? ? :final_visit_requests : :visit_requests)
    end

    def visitors_ids
      @visitors_ids ||= User::EventVisitors.call(event_id: event.id).ids
    end
  end
end
