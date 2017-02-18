class HomeController < ApplicationController
  # TODO [1.1] Remove
  helper_method :event, :talks, :visit_request, :attendees

  def index
    render 'events/show'
  end

  def coming_soon
    render layout: 'coming_soon'
  end

  private

  def event
    @event ||= Event.potential_next
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
