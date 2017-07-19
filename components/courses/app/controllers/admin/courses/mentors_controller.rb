module Admin
  module Courses
    class MentorsController < BaseController
      helper_method :mentors, :mentor, :available_for_mentoring
      before_action :add_new_breadcump,  only: %i[new create]
      before_action :add_season_breadcrumb, :add_mentor_breadcrumb

      def new
        @mentor = current_season.mentors.build
        render_form
      end

      def create
        @mentor = current_season.mentors.build(mentor_params)
        react_to @mentor.save
      end

      def destroy
        return react_to mentor.destroy if policy.allowed_to_destroy?
        redirect_to admin_courses_season_mentors_path, alert: t('courses.flash.season-creator-destroy')
      end

      private

      def add_mentor_breadcrumb
        add_breadcrumb 'mentors.plural', path: admin_courses_season_mentors_path(current_season)
      end

      def default_redirect
        redirect_to admin_courses_season_mentors_path
      end

      def mentors
        current_season.mentors.includes(:user)
      end

      def mentor
        @mentor ||= ::Courses::Mentor.find(params[:id])
      end

      def available_for_mentoring
        @mentors ||= Mentor::AvailableForMentoring.call(current_season)
      end

      def policy
        Mentor::MentorPolicy.new(mentor, current_season)
      end

      def mentor_params
        params.require(:mentor).permit(:user_id)
      end
    end
  end
end
