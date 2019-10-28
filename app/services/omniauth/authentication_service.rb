# frozen_string_literal: true

module Omniauth
  class AuthenticationService
    delegate :authenticated?, to: :policy
    delegate :uid, :provider, :first_name, :last_name, :email, to: :resolver

    def initialize(params)
      @params = params
    end

    def authenticate
      return user if authenticated?
    end

    private

    attr_reader :params

    def resolver
      @resolver ||= ::Omniauth::Resolver.call(params)
    end

    def policy
      @policy ||= AuthenticationPolicy.new(
        user:     user,
        identity: identity
      )
    end

    def user
      @user ||= identified_user || found_user
    end

    def identified_user
      identity.user
    end

    def found_user
      user = ::User.find_or_initialize_by(email: email) do |u|
        u.email      = email
        u.first_name = first_name
        u.last_name  = last_name
        u.password   = Devise.friendly_token[0, 20]
      end
      if user.new_record?
        user.save
        identity.update(user_id: user.id)
      end
      user
    end

    def identity
      @identity ||= ::Identity.find_or_create_by(
        uid:      uid,
        provider: provider
      )
    end
  end
end
