class HomeController < ApplicationController
  # TODO [1.1] Remove
  helper_method :event, :talks, :visit_request, :attendees, :upcoming_date

  def index
    render 'events/show' if event.present?
  end

  private

  def upcoming_date
    next_event = Event.last
    return 'soon' unless next_event
    started_at = next_event.started_at
    started_at.strftime("#{started_at.day.ordinalize} of %B")
  end

  def event
    @event ||= Event.upcoming
  end

  def talks
    @talk ||= event.talks.includes(:speaker)
  end

  # TODO [1.1] Remove
  def visit_request
    return unless current_user

    @visit_request ||= VisitRequest.find_by(
      user_id: current_user.id, event_id: event.id
    )
  end

  # TODO [1.1] Remove
  def attendees
    @attendees ||= event.visit_requests.approved
  end
end
