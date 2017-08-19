module Admin
  module Courses
    module InterviewHelper
      def interview_form_url
        params[:action] == 'edit' ? admin_courses_season_interview_path : admin_courses_season_interviews_path
      end

      def interview_form_method
        params[:action] == 'edit' ? :put : :post
      end

      def courses_interview_assessment_form_url(season, assessment, interview)
        if assessment.new_record?
          admin_courses_season_interview_interview_assessments_path(season, interview)
        else
          admin_courses_season_interview_interview_assessment_path(season, interview, assessment)
        end
      end

      def courses_interview_assessment_form_method(assessment)
        assessment.new_record? ? :post : :put
      end

      def courses_interview_assessments_form(season, interview_assessment, interview)
        return unless ::Courses::Interview::RatePolicy.new(interview).allowed?

        render 'admin/courses/interview_assessments/form',
          season: season, interview_assessment: interview_assessment, interview: interview
      end

      def courses_interview_average_assessments(average_assessments)
        return unless ::Courses::Interview::RatePolicy.new(interview).allowed?

        render 'admin/courses/interview_assessments/average_marks', average_assessments: average_assessments
      end

      def courses_average_mark(hsh)
        "#{hsh[:question]}: #{hsh[:mark]}"
      end

      def approve_after_interview_button(user, season, interview)
        student = interview.student

        return t('courses.interviews.approved') if student.present? && student.attending?

        policy = ::Courses::Interview::ApprovePolicy.new(user, season, interview)
        return '-' unless policy.allowed?

        link_to t('courses.interviews.approve'),
                admin_courses_season_student_path(
                    season.id,
                    student,
                    student: { status: :attending }
                ),
                method: :put, class: 'ui button green',
                data: { confirm: t('phrases.confirm') }
      end
    end
  end
end
