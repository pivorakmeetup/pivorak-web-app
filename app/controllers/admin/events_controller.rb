module Admin
  class EventsController < BaseController
    helper_method :event, :events

    def new
      @event = Event.new
    end

    def create
      @event = Event.new(event_params)

      event.save ? redirect_to(event) : render(:new)
    end

    def update
      event.update(event_params) ? redirect_to(event) : render(:edit)
    end

    private

    def event
      @event ||= Event.friendly.find(params[:id])
    end

    def events
      @events ||= Event.order(started_at: :desc)
    end

    def event_params
      params.require(:event).permit(
        :title, :description, :agenda, :started_at, :finished_at, :limitation, :cover
      )
    end
  end
end
