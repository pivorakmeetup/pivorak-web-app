class User
  class Update < Base
    def call
      if missed_password?
        user.update_without_password(user_params)
      else
        user.update(user_params)
      end
    end

    private

    def missed_password?
      password.blank? && password_confirmation.blank?
    end
  end
end
