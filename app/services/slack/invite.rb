module Slack
  class Invite

    INVITE_URL = 'https://slack.com/api/users.admin.invite'.freeze

    def initialize(args = {})
      @args = args
    end

    def call
      Client.new(url: INVITE_URL, params: params).call
    end

    private

    attr_reader :args

    def params
      {
          email: args[:email],
          resend: true
      }
    end
  end
end
