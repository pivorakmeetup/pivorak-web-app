class EventsController < ApplicationController
  disabled_feature_until '1.2'

  helper_method :visit_request, :event, :events, :attendees, :talks

  private

  def attendees
    @attendees ||= Profiling::User::EventAttendees.call(event_id: event.id)
  end

  def event
    @event ||= Event.friendly.find(params[:id])
  end

  def events
    @events ||= Event.display.published
  end

  def talks
    @talk ||= event.talks.includes(:speaker)
  end

  def visit_request
    return unless current_user_id

    @visit_request ||= VisitRequest.find_by(
      user_id: current_user_id, event_id: event.id
    )
  end
end
