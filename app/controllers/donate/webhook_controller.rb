module Donate
  class WebhookController < ApplicationController
    skip_before_action :verify_authenticity_token

    # POST /donate/webhook
    def create
      Donate::SendNewDonateNotification.call(payload_params)
    end

    private

    def payload_params
      payload = params.except('controller', 'action').keys.first
      JSON.parse(payload).symbolize_keys
    end
  end
end
