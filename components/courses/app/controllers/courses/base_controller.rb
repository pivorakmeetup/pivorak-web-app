module Courses
  class BaseController < ApplicationController
    before_action :authenticate_user!
    helper_method :current_season

    def current_season
      @current_season ||= ::Courses::Season.friendly.find(params[:season_id])
    end

    private

    def render_form
      render :form
    end

    def react_to(action)
      if action
        flash_success and default_redirect
      else
        flash_error and render_form
      end
    end
  end
end
