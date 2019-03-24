# frozen_string_literal: true

module Chat
  class Invite < ApplicationService
    INVITE_URL = 'https://slack.com/api/users.admin.invite'

    def initialize(email)
      @email = email
    end

    def call
      return if email.blank?

      Client.new(url: INVITE_URL, params: params).call
    end

    private

    attr_reader :email

    def params
      default_params.merge(email: email)
    end

    def default_params
      {
        resend: true
      }
    end
  end
end
