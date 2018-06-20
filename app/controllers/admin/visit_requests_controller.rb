module Admin
  class VisitRequestsController < ::Admin::BaseController
    helper_method :visit_requests, :event, :visitors_ids, :confirmed_ids, :applied_ids,
                  :pending_ids, :approved_ids

    before_action :only_supervisor!

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
      @visit_requests ||= search_against(base_scope).includes(:user).order('users.first_name')
    end

    def base_scope
      event.send(event.live? ? :final_visit_requests : :visit_requests)
    end

    def visitors_ids
      @visitors_ids ||= User::EventVisitors.call(event_id: event.id).ids
    end

    def confirmed_ids
      @confirmed_ids ||= User::EventAttendees.call(event_id: event.id).ids
    end

    def applied_ids
      @applied_ids ||= User::EventApplied.call(event_id: event.id).ids
    end

    def pending_ids
      @pending_ids ||= User::EventParticipantsByStatus.call(
        event_id: event.id,
        status: ::VisitRequest::PENDING
      ).ids
    end

    def approved_ids
      @approved_ids ||= User::EventParticipantsByStatus.call(
        event_id: event.id,
        status: ::VisitRequest::APPROVED
      ).ids
    end
  end
end
