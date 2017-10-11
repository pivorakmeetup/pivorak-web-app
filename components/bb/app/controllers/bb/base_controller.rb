module Bb
  class BaseController < ::ApplicationController
    before_action :authenticate_user!

    helper_method :access_policy, :current_member

    def access_policy
      @access_policy ||= AccessPolicy.new(current_user)
    end

    def current_member
      @current_member ||= Member.find_by(user_id: current_user.id)
    end
  end
end
