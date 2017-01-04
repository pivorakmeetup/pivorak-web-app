module Admin
  class EventsController < BaseController
    helper_method :event, :events, :venues

    def new
      @event = Event.new
    end

    def create
      @event = Event.new(event_params)

      event.save ? default_redirect : render(:new)
    end

    def update
      event.update(event_params) ? default_redirect : render(:edit)
    end

    private

    def default_redirect
      redirect_to edit_admin_event_path(event)
    end

    def event
      @event ||= Event.friendly.find(params[:id])
    end

    def events
      @events ||= Event.order(started_at: :desc).includes(:venue)
    end

    def venues
      @venues ||= Venue.all
    end

    def event_params
      params.require(:event).permit(
        :title, :description, :agenda, :started_at, :finished_at, :venue_id,
        :limit_total, :limit_verified, :cover, :published, :status
      )
    end
  end
end
