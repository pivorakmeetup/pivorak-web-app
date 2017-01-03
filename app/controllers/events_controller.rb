class EventsController < ApplicationController
  helper_method :visit_request, :event, :events

  private

  def visit_request
    @visit_request ||= VisitRequest::FindNotCanceled.call(current_user, event)
  end

  def event
    @event ||= Event.friendly.find(params[:id])
  end

  def events
    @events ||= Event.display.published
  end
end
