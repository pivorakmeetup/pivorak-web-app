# frozen_string_literal: true

class VisitRequestsController < ApplicationController
  before_action :authenticate_user!, only: %i[create destroy]

  def show
    VisitRequest::FinalDecision.call(visit_request, answer: params[:answer])
    sign_in(:user, visit_request.user)

    flash_success(visit_request.status) && default_redirect
  end

  def create
    VisitRequest::Create.call(current_user, event)

    flash_success(user_verification_status) && default_redirect
  end

  def destroy
    VisitRequest::Cancel.call(visit_request)

    flash_success && default_redirect
  end

  private

  def default_redirect
    redirect_to root_path # redirect_to event_path(event) TODO [1.1]
  end

  def event
    @event ||= Event.friendly.find(params[:event_id])
  end

  def visit_request
    @visit_request ||= VisitRequest.find_by!(token: params[:token])
  end

  def user_verification_status
    current_user.verified? ? :success_for_verified : :success_for_newbies
  end
end
