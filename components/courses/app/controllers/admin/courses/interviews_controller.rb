module Admin
  module Courses
    class InterviewsController < BaseController
      helper_method :interviews, :interview, :assessment, :questions,
        :assessments_hash, :average_assessment

      breadcrumps do
        add :interviews_breadcrumb
        add :interview_breadcrumb, only: %i[show edit update]
      end

      def new
        @interview = current_season.interviews.new
        render_form
      end

      def create
        @interview = current_season.interviews.new(interviews_params)
        react_to interview.save
      end

      def update
        react_to interview.update(interviews_params)
      end

      private

      def default_redirect
        redirect_to admin_courses_season_interviews_path(current_season)
      end

      def interview
        @interview ||= ::Courses::Interview.find(params[:id])
      end

      def interviews
        @interviews ||= current_season.interviews
          .includes(:mentor)
          .includes(student: :user)
          .includes(:interview_assessments)
          .page(params[:page])
      end

      def interviews_breadcrumb
       add_breadcrumb 'courses.interviews.plural',
         path: admin_courses_season_interviews_path(current_season)
      end

      def interview_breadcrumb
        label_data = interview.student ? :full_name : :status

        add_breadcrumb interview, label: label_data,
          path: admin_courses_season_interview_path(current_season, interview)
      end

      def interviews_params
        params.require(:interview).permit(:start_at, :description, :video_url, :status)
          .merge(mentor_id: mentor_id)
      end

      def mentor_id
        ::Courses::Mentor
          .find_by(season_id: current_season.id, user_id: current_user.id).id
      end

      def assessment(interview, question)
        ::Courses::InterviewAssessment.find_or_initialize_by(mentor_id:    interview.mentor_id,
                                                             interview_id: interview.id,
                                                             question_id:  question.id)
      end

      def questions
        current_season.questions
      end

      def assessments_hash
        @assessments_hash ||= ::Courses::Interview::AssessmentsHash
          .call(interviews, questions)
          .sort_by { |k, v| -v[:average] }
      end

      def average_assessment
        @average_assessment ||= ::Courses::Interview::AverageAssessment.new(interview, questions).call
      end
    end
  end
end
