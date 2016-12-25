module Users
  class RegistrationsController < Devise::RegistrationsController
    def create
      user = User::CheckSynthetic.call(params[:user][:email])

      user ? redirect_to(new_user_password_path(synthetic: user.email)) : super
    end

    protected

    def sign_up_params
      params.require(:user).permit(:email, :first_name, :last_name, :password, :password_confirmation)
    end
  end
end
