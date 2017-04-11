class User
  class GetReal < ApplicationService
    def initialize(user_id)
      @user_id = user_id
    end

    def call
      return unless user&.synthetic?

      user.update(synthetic: false)
    end

    private

    attr_reader :user_id

    def user
      @user ||= User.find(user_id)
    end
  end
end
