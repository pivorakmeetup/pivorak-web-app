module Admin
  class EventsController < BaseController
    helper_method :event, :events, :venues

    def new
      @event = Event.new
    end

    def create
      @event = Event.new(event_params)

      if event.save
        flash_success(:events)
        default_redirect
      else
        render(:new)
      end
    end

    def update
      if event.update(event_params)
        flash_success(:events)
        default_redirect
      else
        render(:edit)
      end
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
        :limit_total, :limit_verified, :cover, :published, :status, talk_ids: []
      )
    end
  end
end
