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
