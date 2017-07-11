module Admin
  module Courses
    class MentorsController < BaseController
      helper_method :mentors
      add_breadcrumb 'seasons.plural', :admin_courses_seasons_path
      add_breadcrumb 'mentors.plural', :admin_courses_seasons_path
      before_action :add_new_breadcump,  only: %i[new create]
      before_action :add_edit_breadcump, only: %i[edit update]
      before_action :set_season

      def new
        @mentor = @season.mentors.build
        render_form
      end

      def create
        @mentor = @season.mentors.build(mentor_params)
        react_to @mentor.save
      end

      def destroy
        @mentor = ::Courses::Mentor.find(params[:id])
        react_to @mentor.destroy
      end

      private

      def set_season
        @season ||= ::Courses::Season.friendly.find(params[:season_id])
      end

      def default_redirect
        redirect_to admin_courses_season_mentors_path
      end

      def mentors
        @season.mentors
      end

      def mentor_params
        params.require(:mentor).permit(:user_id)
      end
    end
  end
end
