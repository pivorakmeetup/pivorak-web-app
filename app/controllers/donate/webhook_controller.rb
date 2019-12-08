module Donate
  class WebhookController < ApplicationController
    skip_before_action :verify_authenticity_token

    # POST /donate/webhook
    def create
      Donate::SendNewDonateNotification.call(payload_params)
    end

    private

    def payload_params
      params.permit(:amount, :currency, :clientName)
    end
  end
end
