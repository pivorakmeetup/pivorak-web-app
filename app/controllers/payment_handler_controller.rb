class PaymentHandlerController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    Liqpay::Charge::Handler.(params[:data])

    head :ok
  end
end
