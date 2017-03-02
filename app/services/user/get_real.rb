class User
  class GetReal < ApplicationService
    def initialize(user)
      @user = user
    end

    def call
      return unless user.synthetic?

      user.update(synthetic: false)
    end

    private

    attr_reader :user
  end
end
