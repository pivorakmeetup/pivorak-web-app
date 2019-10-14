# frozen_string_literal: true

module Admin
  module Courses
    class InterviewAssessmentsController < ::Admin::Courses::BaseController
      skip_before_action :execute_show_tab_policy

      helper_method :interview, :assessment

      def create
        interview.interview_assessments.create(interview_assessment_params)
        redirect_back(fallback_location: current_season)
      end

      def update
        assessment.update(interview_assessment_params)
        redirect_back(fallback_location: current_season)
      end

      private

      def interview
        @interview ||= ::Courses::Interview.find(params[:interview_id])
      end

      def assessment
        @assessment ||= ::Courses::InterviewAssessment.find(params[:id])
      end

      def interview_assessment_params
        params.require(:interview_assessment)
              .permit(assessments_attributes: %i[id question_id mark])
              .merge(mentor_id: mentor_id)
      end

      def mentor_id
        ::Courses::Mentor
          .find_by(season_id: current_season.id, user_id: current_user.id).id
      end
    end
  end
end
