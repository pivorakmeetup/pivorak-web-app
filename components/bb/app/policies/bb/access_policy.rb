module Bb
  class AccessPolicy
    def initialize(user)
      @user = user
    end

    def allowed?
      already_member?
    end

    def knock?
      !already_member?
    end

    private

    attr_reader :user

    def already_member?
      @already_member ||= ::Bb::Member.find_by(user_id: user.id)
    end
  end
end
