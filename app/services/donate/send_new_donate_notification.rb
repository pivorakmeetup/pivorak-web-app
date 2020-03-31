# frozen_string_literal: true

# Donate::SendNewDonateNotification.call(amount: 5, currency: 'USD', orderReference: 'foo-123')
module Donate
  class SendNewDonateNotification < ApplicationService
    attr_reader :amount, :currency, :order_reference

    def initialize(params)
      @amount = params.fetch(:amount)
      @currency = params.fetch(:currency)
      @order_reference = params.fetch(:orderReference)
    end

    def call
      return if amount.zero?
      return if donation_data.persisted?

      donation_data.save!

      SlackNotifier.call(
        channel: ENV.fetch('SLACK_NEW_DONATION_CHANNEL'),
        message: message
      )
    end

    private

    def donation_data
      @donation_data ||= DonationData.find_or_initialize_by(order_reference: order_reference)
    end

    def message
      I18n.t('slack.new_donation_notification_message', amount: amount, currency: currency)
    end
  end
end
