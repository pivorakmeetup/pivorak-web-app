# frozen_string_literal: true

class HomeController < ApplicationController
  # TODO: [1.1] Remove
  helper_method :event, :talks, :visit_request, :attendees, :planned_event, :upcoming_date

  def index
    if event
      render 'events/show'
    else
      render :index
    end
  end

  private

  def upcoming_date
    return 'soon' unless planned_event.present?

    started_at = planned_event.started_at
    started_at.strftime("#{started_at.day.ordinalize} of %B")
  end

  def event
    @event ||= Event.upcoming
  end

  def planned_event
    Event.planned.last
  end

  def talks
    @talks ||= event.talks.includes(:speaker)
  end

  # TODO: [1.1] Remove
  def visit_request
    return unless current_user

    @visit_request ||= VisitRequest.find_by(
      user_id: current_user.id, event_id: event.id
    )
  end

  # TODO: [1.1] Remove
  def attendees
    @attendees ||= event.visit_requests.approved
  end
end
