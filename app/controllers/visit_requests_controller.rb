class VisitRequestsController < ApplicationController
  before_action :authenticate_user!

  def create
    VisitRequest::Create.call(current_user, event)

    default_redirect
  end

  def destroy
    visit_request.destroy

    default_redirect
  end

  private

  def default_redirect
    redirect_to event_path(event)
  end

  def event
    @event ||= Event.friendly.find(params[:event_id])
  end

  def visit_request
    @visit_request ||= VisitRequest.find(params[:id])
  end
end
