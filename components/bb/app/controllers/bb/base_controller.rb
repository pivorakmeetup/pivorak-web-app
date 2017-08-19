module Bb
  class BaseController < ApplicationController
    before_action :authenticate_user!

    helper_method :access_policy

    def access_policy
      @access_policy ||= AccessPolicy.new(current_user)
    end
  end
end
