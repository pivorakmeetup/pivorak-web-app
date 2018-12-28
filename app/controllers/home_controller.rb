class HomeController < ApplicationController
  # TODO [1.1] Remove
  helper_method :event, :talks, :visit_request, :attendees

  def index
    if coming_soon?
      render 'coming_soon/show'
    else
      render 'events/show'
    end
  end

  private

  def coming_soon?
    ActiveModel::Type::Boolean.new.cast(Ez::Settings[:app, :home, :coming_soon])
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
