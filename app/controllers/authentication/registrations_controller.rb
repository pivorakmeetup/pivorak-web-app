module Authentication
  class RegistrationsController < Devise::RegistrationsController
    def create
      synthetic_user = User::CheckSynthetic.call(params[:user][:email])
      if synthetic_user
        flash[:success] = I18n.t('synthetic_user.reset_password')
        synthetic_user.send_reset_password_instructions
        return redirect_to root_path
      end

      super
      NotifyMailer.new_user_registered(resource.id).deliver_later if resource.persisted?
    end

    protected

    def sign_up_params
      params.require(:user).permit(:email, :first_name, :last_name, :password, :password_confirmation)
    end
  end
end
