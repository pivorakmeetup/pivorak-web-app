module Omniauth
  class AuthenticationService
    delegate :authenticated?, to: :policy

    def initialize(params)
      @uid          = params[:uid]
      @provider     = params[:provider]
      @first_name, @last_name, @email = params.fetch(:info, {}).values_at(:first_name, :last_name, :email)
    end

    def authenticate
      return user if authenticated?
    end

    private

    attr_reader :uid, :provider, :email, :first_name, :last_name

    def policy
      @policy ||= AuthenticationPolicy.new(
        user:     user,
        identity: identity
      )
    end

    def user
      @user ||= ::User.find_or_create_by(email: email) do |user|
        user.email      = email
        user.first_name = first_name
        user.last_name  = last_name
        user.password   = Devise.friendly_token[0, 20]
      end
    end

    def identity
      @identity ||= ::Identity.find_or_create_by(
        uid:      uid,
        provider: provider,
        user:     user
      )
    end
  end
end
