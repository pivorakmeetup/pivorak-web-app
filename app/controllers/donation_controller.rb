class DonationController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create

  def create
    notification

    redirect_to root_path
  end

  private

  def handler_result
    @handler_result ||= params[:data] ? Liqpay::Charge::Handler.(params[:data]) : {}
  end

  def status
    @status ||= handler_result[:status]
  end

  def notification
    if status.present? && status == 'success'
      flash[:notice] = t 'donations.success'
    elsif status.present?
      flash[:error] = t 'liqpay.status.failure'
    end
  end
end
