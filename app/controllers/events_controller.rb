class EventsController < ApplicationController
  disabled_feature_until '1.3'

  helper_method :visit_request, :event, :events, :attendees

  private

  def attendees
    @attendees ||= User::EventAttendees.call(event_id: event.id)
  end

  def event
    @event ||= Event.friendly.find(params[:id])
  end

  def events
    @events ||= Event.display.published
  end

  def visit_request
    return unless current_user

    @visit_request ||= VisitRequest.find_by(
      user_id: current_user.id, event_id: event.id
    )
  end
end
