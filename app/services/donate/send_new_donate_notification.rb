# Donate::SendNewDonateNotification.call('amount' => 5, 'currency' => 'USD')
module Donate
  class SendNewDonateNotification < ApplicationService
    attr_reader :params

    def initialize(params)
      @params = params
    end

    def call
      SlackNotifier.call(
        channel: ENV.fetch('SLACK_NEW_DONATION_CHANNEL'),
        message: message
      )
    end

    private

    def message
      I18n.t('slack.new_donation_notification_message',
        amount: params.fetch('amount'),
        currency: params.fetch('currency')
      )
    end
  end
end
