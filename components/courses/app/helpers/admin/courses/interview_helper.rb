module Admin
  module Courses
    module InterviewHelper
      def interview_form_url
        params[:action] == 'edit' ? admin_courses_season_interview_path : admin_courses_season_interviews_path
      end

      def interview_form_method
        params[:action] == 'edit' ? :put : :post
      end

      def courses_interview_assessment_form_url(assessment)
        if assessment.new_record?
          admin_courses_season_interview_interview_assessments_path(current_season, interview)
        else
          admin_courses_season_interview_interview_assessment_path(current_season, interview, assessment)
        end
      end

      def courses_interview_assessments_table(questions, interview)
        return unless ::Courses::Interview::RatePolicy.new(interview).allowed?

        render 'admin/courses/interview_assessments/table', questions: questions, interview: interview
      end

      def courses_interview_average_assessments(average_assessments)
        return unless ::Courses::Interview::RatePolicy.new(interview).allowed?

        render 'admin/courses/interview_assessments/average_marks', average_assessments: average_assessments
      end

      def courses_average_mark(hsh)
        "#{hsh[:question]}: #{hsh[:mark]}"
      end
    end
  end
end
