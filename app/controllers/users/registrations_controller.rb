module Users
  class RegistrationsController < Devise::RegistrationsController
    def create
      synthetic_user = User::CheckSynthetic.call(params[:user][:email])
      return redirect_to(new_user_password_path(synthetic: synthetic_user.email)) if synthetic_user

      super

      NotifyMailer.new_user_registered(resource.id).deliver_later if resource.persisted?
    end

    protected

    def sign_up_params
      params.require(:user).permit(:email, :first_name, :last_name, :password, :password_confirmation)
    end
  end
end
