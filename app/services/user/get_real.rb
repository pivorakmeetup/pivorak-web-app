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
      @user ||= User.synthetic.find_by(confirmation_token: token)
    end
  end
end
