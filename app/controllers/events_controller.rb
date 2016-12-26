class EventsController < ApplicationController
  helper_method :visit_request, :event, :events

  def show
  end

  def index
  end

  private

  def visit_request
    @visit_request ||= VisitRequest::FindNotCanceled.call(current_user, event)
  end

  def event
    @event ||= Event.friendly.find(params[:id])
  end

  def events
    @events ||= Event.all
  end

end
