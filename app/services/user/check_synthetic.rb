class User
  class CheckSynthetic < ApplicationService
    def initialize(email)
      @email = email
    end

    def call
      return unless email

      user
    end

    private

    attr_reader :email

    def user
      @user ||= User.synthetic.find_by(email: email)
    end
  end
end
