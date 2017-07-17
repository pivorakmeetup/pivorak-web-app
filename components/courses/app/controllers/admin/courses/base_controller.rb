module Admin
  module Courses
    class BaseController < ::Admin::BaseController
      helper_method :current_season
      before_action :authenticate_mentor!

      add_breadcrumb 'courses.plural', :admin_courses_seasons_path
      before_action :add_new_breadcump,  only: %i[new create]
      before_action :add_edit_breadcump, only: %i[edit update]

      private

      def add_season_breadcrumb
        add_breadcrumb current_season,
          path: admin_courses_season_path(current_season)
      end

      def current_season
        @current_season ||= ::Courses::Season
          .friendly
          .find(params[:season_id] ||= params[:id])
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
