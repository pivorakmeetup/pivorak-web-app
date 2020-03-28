# frozen_string_literal: true

# Donate::SendNewDonateNotification.call('amount' => 5, 'currency' => 'USD')
module Donate
  class SendNewDonateNotification < ApplicationService
    attr_reader :amount, :currency

    def initialize(params)
      @amount = params.fetch(:amount)
      @currency = params.fetch(:currency)
    end

    def call
      return if amount.zero?

      SlackNotifier.call(
        channel: ENV.fetch('SLACK_NEW_DONATION_CHANNEL'),
        message: message
      )
    end

    private

    def message
      I18n.t('slack.new_donation_notification_message', amount: amount, currency: currency)
    end
  end
end
