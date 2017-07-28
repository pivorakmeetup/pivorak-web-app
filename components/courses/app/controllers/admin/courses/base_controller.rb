module Admin
  module Courses
    class BaseController < ::Admin::BaseController
      helper_method :current_season, :current_mentor

      def self.breadcrumps(&block)
        before_action :add_season_breadcrumb

        instance_eval(&block)

        before_action :add_new_breadcump,  only: %i[new create]
        before_action :add_edit_breadcump, only: %i[edit update]
      end

      def self.add(b, options = {})
        before_action b, options
      end

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

      def current_mentor
        @current_mentor ||= current_season.mentors
          .find_by(user_id: current_user.id)
      end

      def authenticate_mentor!
        return if current_season_has_current_user_as_a_mentor?

        redirect_to admin_courses_seasons_path,
          alert: t('courses.flash.mentor-access-denied')
      end

      before_action :authenticate_mentor!

      add_breadcrumb 'courses.plural', :admin_courses_seasons_path

      def current_season_has_current_user_as_a_mentor?
        ::Courses::Mentor.exists?(
          user_id:   current_user.id,
          season_id: current_season.id
        )
      end
    end
  end
end
