module Courses
  class Interview < ApplicationRecord
    class RatePolicy

      def initialize(interview)
        @interview = interview
      end

      def allowed?
        interview_has_a_student? &&
          interview_has_a_video_url? &&
          interview_is_completed? &&
          student_has_interviewing_status?
      end

      private

      attr_reader :interview

      def interview_has_a_student?
        interview.student
      end

      def interview_has_a_video_url?
        interview.video_url
      end

      def interview_is_completed?
        interview.completed?
      end

      def student_has_interviewing_status?
        interview.student.interviewing?
      end
    end
  end
end
