module Admin
  class EventsController < BaseController
    helper_method :event, :events, :venues
    add_breadcrumb 'events.plural', :admin_events_path
    before_action :add_new_breadcump,  only: %i[new create]
    before_action :add_edit_breadcump, only: %i[edit update]

    def new
      @event = Event::New.call
      render_form
    end

    def create
      @event = Event.new(event_params)

      respond_for event.save
    end

    def update
      respond_for event.update(event_params)
    end

    private

    def default_redirect
      redirect_to edit_admin_event_path(event)
    end

    def event
      @event ||= Event.friendly.find(params[:id])
    end

    def events
      @events ||= search_against(Event).order(started_at: :desc).page(params[:page])
    end

    def venues
      @venues ||= Venue.all
    end

    def event_params
      params.require(:event).permit(
        :title, :description, :agenda, :started_at, :finished_at, :venue_id,
        :limit_total, :limit_verified, :cover, :published, :status, talk_ids: []
      )
    end
  end
end
