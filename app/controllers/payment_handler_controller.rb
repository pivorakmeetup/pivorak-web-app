class PaymentHandlerController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    Liqpay::Charge::Handler.(donation_params)

    head :no_content
  end

  private

  def donation_params
    {
      data:    params[:data],
      user_id: current_user_id
    }
  end
end
