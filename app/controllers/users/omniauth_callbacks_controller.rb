module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def handle_callback
      user = handler.authenticate
      user ? sign_in_and_redirect(user) : redirect_to(new_user_session_path)
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
