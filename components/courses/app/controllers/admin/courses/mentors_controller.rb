# frozen_string_literal: true

module Admin
  module Courses
    class MentorsController < ::Admin::Courses::BaseController
      helper_method :mentors, :mentor, :available_for_mentoring

      breadcrumps do
        add :mentors_breadcrumb
      end

      def new
        @mentor = current_season.mentors.build
        render_form
      end

      def create
        @mentor = current_season.mentors.build(mentor_params)

        react_to @mentor.save
      end

      def destroy
        return react_to mentor.destroy if policy.allowed?

        redirect_to admin_courses_season_mentors_path,
                    alert: t('courses.flash.season-creator-destroy')
      end

      private

      def mentors_breadcrumb
        add_breadcrumb 'courses.mentors.plural',
                       path: admin_courses_season_mentors_path(current_season)
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
        @available_for_mentoring ||= ::Courses::Mentor::AvailableForMentoring.call(current_season)
      end

      def policy
        ::Courses::Mentor::DestroyPolicy.new(mentor, current_season)
      end

      def mentor_params
        params.require(:mentor).permit(:user_id)
      end
    end
  end
end
