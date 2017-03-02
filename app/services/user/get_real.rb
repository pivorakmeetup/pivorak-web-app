class User
  class GetReal < ApplicationService
    def initialize(user)
      @user = user
    end

    def call
      @user.update(synthetic: false)
    end
  end
end
