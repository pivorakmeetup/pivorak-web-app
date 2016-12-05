module Invite
  class Create
    def initialize(args = {})
      @email = args.fetch(:email)
    end

    def call
      Slack::Invite.new(email: email).call
    end

    private

    attr_reader :email
  end
end
