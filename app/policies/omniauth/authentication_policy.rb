module Omniauth
  class AuthenticationPolicy
    def initialize(params)
      @identity = params[:identity]
      @user     = params[:user]
    end

    def authenticated?
      persisted? && linked_identity?
    end

    private

    attr_reader :identity, :user

    def linked_identity?
      identity.user.eql?(user)
    end

    def persisted?
      user && user.persisted? && identity && identity.persisted?
    end
  end
end
