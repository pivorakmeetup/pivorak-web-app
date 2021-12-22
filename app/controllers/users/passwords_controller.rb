# frozen_string_literal: true

module Users
  class PasswordsController < Devise::PasswordsController
    include Users::Concerns::Recaptcha
    prepend_before_action :check_captcha, only: :create

    after_action only: :update do
      User::GetReal.call(current_user)
    end

    def create
      super
    end

    private

    def user_params
      params.require(:user).permit(:email)
    end
  end
end
