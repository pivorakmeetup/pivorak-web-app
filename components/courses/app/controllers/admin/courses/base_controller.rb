module Admin
  module Courses
    class BaseController < ::Admin::BaseController
      helper_method :current_season
      before_action :authenticate_mentor!
      add_breadcrumb 'courses.plural', :admin_courses_seasons_path

      def add_season_breadcrumb
        add_breadcrumb current_season,
          path: admin_courses_season_path(current_season)
      end


      private

      def current_season
        @current_season ||= ::Courses::Season
          .friendly
          .find(params[:season_id] ||= params[:id])
      end

      def authenticate_mentor!
        return if current_season_has_current_user_as_a_mentor?

        redirect_to admin_courses_seasons_path,
          alert: t('courses.flash.mentor-access-denied')
      end

      def current_season_has_current_user_as_a_mentor?
        ::Courses::Mentor.exists?(
          user_id:   current_user.id,
          season_id: current_season.id
        )
      end
    end
  end
end
