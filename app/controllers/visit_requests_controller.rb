class VisitRequestsController < ApplicationController
  before_action :authenticate_user!, only: %i[create destroy]

  def show
    VisitRequest::FinalConfirmation.call(visit_request, params)

    default_redirect
  end

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
