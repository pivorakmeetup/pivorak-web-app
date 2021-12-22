# frozen_string_literal: true

module Admin
  class EventsController < BaseController
    helper_method :event, :events, :venues
    add_breadcrumb 'events.plural', :admin_events_path
    before_action :add_new_breadcump,  only: %i[new create]
    before_action :add_edit_breadcump, only: %i[edit update]

    before_action :only_supervisor!

    def new
      @event = Event::New.call
      render_form
    end

    def create
      @event = Event.new(event_params)

      react_to event.save
    end

    def edit
      super
    end

    def update
      react_to event.update(event_params)
    end

    private

    def default_redirect
      redirect_to edit_admin_event_path(event)
    end

    def event
      @event ||= Event.friendly.find(params[:id])
    end

    def events
      @events ||= ::Event::List.call(events: search_against(Event), page: params[:page])
                               .per(Ez::Settings[:app, :events, :default_events_per_page])
    end

    def venues
      @venues ||= Venue.all
    end

    def event_params
      params.require(:event).permit(
        :title, :description, :agenda, :started_at, :finished_at, :venue_id,
        :facebook_embeded_post,
        :limit_total, :limit_verified, :cover, :published, :status, talk_ids: []
      )
    end
  end
end
