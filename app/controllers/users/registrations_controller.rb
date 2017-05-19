module Users
  class RegistrationsController < Devise::RegistrationsController
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
        NotifyMailer.new_user_registered(resource.id).deliver_later
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
