module Users
  class RegistrationsController < Devise::RegistrationsController
    include Users::Concerns::Recaptcha
    prepend_before_action :check_captcha, only: :create
    alias_method :user_params, :sign_up_params

    def create
      synthetic_user = User::CheckSynthetic.call(params[:user][:email])
      if synthetic_user
        flash[:success] = I18n.t('synthetic_user.reset_password')
        synthetic_user.send_reset_password_instructions
        return redirect_to root_path
      end

      super

      if resource.persisted?
        Mailchimp::SubscriptionJob.perform_later(resource.id)
      end
    end

    protected

    def account_update_params
      params.require(:user).permit(
        :email, :password, :password_confirmation,
        :current_password, :subscribed
      )
    end

    def sign_up_params
      params.require(:user).permit(
        :email, :first_name, :last_name,
        :password, :password_confirmation,
        :subscribed
      )
    end
  end
end
