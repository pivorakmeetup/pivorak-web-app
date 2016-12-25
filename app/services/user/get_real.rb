class User
  class GetReal < ApplicationService
    def initialize(token)
      @token = token
    end

    def call
      return unless token || user

      user.update(synthetic: false)
    end

    private

    attr_reader :token

    def user
      @user ||= User.synthetic.where(confirmation_token: token).first
    end
  end
end
