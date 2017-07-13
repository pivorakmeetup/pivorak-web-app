module Admin
  module Courses
    class BaseController < ::Admin::BaseController
      helper_method :current_season

      def current_season
        @current_season ||= ::Courses::Season.friendly.find(params[:season_id])
      end
    end
  end
end
