class DonationController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create

  # TODO uncomment when page is created
  # def show
  # end

  def create
    result = Liqpay::Charge::Handler.(donation_params)

    router(result[:status])
  end

  private

  def donation_params
    {
      data:    params[:data],
      user_id: current_user_id
    }
  end

  def router(status)
    if status == 'success'
      flash[:notice] = t 'donations.success'
      redirect_to root_path
    else
      flash[:error] = t 'liqpay.status.failure'
      redirect_to root_path
      # TODO uncomment when page is created
      # redirect_to donation_path
    end
  end
end
