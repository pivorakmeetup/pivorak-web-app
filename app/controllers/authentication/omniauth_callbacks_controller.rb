module Authentication
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def handle_callback
      user = handler.authenticate
      user.confirm if user
      if user
        flash[:success] = 'You have successfully logged in'
        sign_in_and_redirect(user)
      else
        flash[:alert] = 'User has invalid details. Please try other OAuth'
        redirect_to(new_user_session_path)
      end
    end

    Devise.omniauth_providers.each { |provider| alias_method provider, :handle_callback }

    private

    def handler
      @handler ||= ::Omniauth::AuthenticationService.new(omniauth_params)
    end

    def omniauth_params
      request.env['omniauth.auth']
    end
  end
end
