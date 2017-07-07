class VisitRequestsController < ApplicationController
  before_action :authenticate_user!, only: %i[create destroy]

  def show
    VisitRequest::FinalConfirmation.call(visit_request, params)

    flash_success(visit_request.status) and default_redirect
  end

  def create
    VisitRequest::Create.call(current_user, event)

    flash_success(user_verification_status) and default_redirect
  end

  def destroy
    visit_request.destroy

    flash_success and default_redirect
  end

  private

  def default_redirect
    redirect_to root_path # redirect_to event_path(event) TODO [1.1]
  end

  def event
    @event ||= Event.friendly.find(params[:event_id])
  end

  def visit_request
    @visit_request ||= VisitRequest.find(params[:id])
  end

  def user_verification_status
    current_user.verified? ? :success_for_verified : :success_for_newbies
  end
end
