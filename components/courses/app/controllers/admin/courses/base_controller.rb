module Admin
  module Courses
    class BaseController < ::Admin::BaseController
      helper_method :current_season
      before_action :authenticate_mentor!

      private

      def add_season_breadcrumb
        add_breadcrumb current_season, path: admin_courses_season_path(current_season)
      end

      def current_season
        @current_season ||= ::Courses::Season.friendly.find(params[:season_id])
      end

      def authenticate_mentor!
        if ::Courses::Mentor.where(user_id: current_user.id, season_id: current_season.id).none?
          redirect_to admin_courses_seasons_path, alert: t('courses.flash.mentor-access-denied')
          false
        end
      end
    end
  end
end
