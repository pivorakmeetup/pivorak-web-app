module Users
  class PasswordsController < Devise::PasswordsController
    after_action only: :update do
      User::GetReal.call(current_user)
    end
  end
end
