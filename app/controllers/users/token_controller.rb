# frozen_string_literal: true

module Users
  class TokenController < ApplicationController
    before_action :authenticate_user!

    def show
      render plain: token
    end

    private

    def token
      @token ||= JWT.encode payload, Rails.application.secrets.secret_key_base
    end

    def payload
      @payload ||= { user_id: current_user.id, exp: 12.hours.from_now.to_i }
    end
  end
end
