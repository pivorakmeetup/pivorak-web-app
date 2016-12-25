module Users
  class PasswordsController < Devise::PasswordsController
    def edit
      User::GetReal.call(params[:reset_password_token])

      super
    end
  end
end
