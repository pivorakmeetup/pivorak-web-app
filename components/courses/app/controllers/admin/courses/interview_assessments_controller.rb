module Admin
  module Courses
    class InterviewAssessmentsController < BaseController
      helper_method :interview, :assessment

      def create
        interview.interview_assessments.create(interview_assessment_params)
      end

      def update
        assessment.update(interview_assessment_params)
      end

      private

      def interview
        ::Courses::Interview.find(params[:interview_id])
      end

      def assessment
        ::Courses::InterviewAssessment.find(params[:id])
      end

      def interview_assessment_params
        params.require(:interview_assessment).permit(:mark, :question_id).merge(mentor_id: mentor_id)
      end

      def mentor_id
        ::Courses::Mentor
          .find_by(season_id: current_season.id, user_id: current_user.id).id
      end
    end
  end
end
