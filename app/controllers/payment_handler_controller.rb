# frozen_string_literal: true

class PaymentHandlerController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    Liqpay::Charge::Handler.call(params[:data])

    head :ok
  end
end
