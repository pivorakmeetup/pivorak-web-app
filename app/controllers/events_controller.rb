class EventsController < ApplicationController
  helper_method :visit_request, :event, :events

  def show
  end

  def index
  end

  private

  def visit_request
    return false unless current_user
    @visit_request ||= VisitRequest.pending.find_by(user_id: current_user.id, event_id: event.id)
  end

  def event
    @event ||= Event.friendly.find(params[:id])
  end

  def events
    @events ||= Event.all
  end

end
