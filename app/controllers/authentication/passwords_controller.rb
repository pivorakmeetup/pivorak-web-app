module Authentication
  class PasswordsController < Devise::PasswordsController
    after_action only: :update do
      User::GetReal.call(current_user.id)
    end
  end
end
