module Bb
  class AccessPolicy
    def initialize(user)
      @user = user
    end

    def allowed?
      already_member?
    end

    def reviewing?
      member && book_under_review?
    end

    def can_knock?
      !already_member?
    end

    private

    attr_reader :user

    def member
      @member ||= ::Bb::Member.find_by(user_id: user.id)
    end

    def already_member?
      member&.verified?
    end

    def book_under_review?
      member.books.first&.moderation?
    end
  end
end
