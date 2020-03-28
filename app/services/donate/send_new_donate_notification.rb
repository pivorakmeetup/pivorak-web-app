# frozen_string_literal: true

# Donate::SendNewDonateNotification.call('amount' => 5, 'currency' => 'USD')
module Donate
  class SendNewDonateNotification < ApplicationService
    attr_reader :amount, :currency, :order_reference

    def initialize(params)
      @amount = params.fetch(:amount)
      @currency = params.fetch(:currency)
      # TODO: Add apropriate fix with DB storage for orderReference
      Rails.logger.info params.inspect
      @order_reference = params.fetch(:orderReference)
      Thread.current[:donations] ||= []
    end

    def call
      return if amount.zero?
      return if Thread.current[:donations].include?(order_reference)
      Thread.current[:donations].push(order_reference)

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
