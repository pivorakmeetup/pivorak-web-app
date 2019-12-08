# frozen_string_literal: true

class SlackNotifier < ApplicationService
  USER_NAME = 'notifier'
  attr_reader :channel, :message

  def initialize(channel:, message:)
    @channel = channel
    @message = message
  end

  def call
    notifier = Slack::Notifier.new(
      ENV.fetch('SLACK_WEBHOOK_URL'),
      channel:  channel,
      username: USER_NAME
    )

    notifier.ping(message)
  end
end
