module Admin
  module Courses
    class MentorsController < BaseController
      helper_method :mentors, :mentor, :current_season
      add_breadcrumb 'seasons.plural', :admin_courses_seasons_path
      add_breadcrumb 'mentors.plural', :admin_courses_seasons_path
      before_action :add_new_breadcump,  only: %i[new create]
      before_action :add_edit_breadcump, only: %i[edit update]

      def new
        @mentor = current_season.mentors.build
        render_form
      end

      def create
        @mentor = current_season.mentors.build(mentor_params)
        react_to @mentor.save
      end

      def destroy
        react_to mentor.destroy
      end

      private

      def current_season
        @season ||= ::Courses::Season.friendly.find(params[:season_id])
      end

      def default_redirect
        redirect_to admin_courses_season_mentors_path
      end

      def mentors
        current_season.mentors
      end

      def mentor
        @mentor ||= ::Courses::Mentor.find(params[:id])
      end

      def mentor_params
        params.require(:mentor).permit(:user_id)
      end
    end
  end
end
