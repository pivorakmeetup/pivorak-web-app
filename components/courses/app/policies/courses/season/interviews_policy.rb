module Courses
  class Season < ApplicationRecord
    class InterviewsPolicy
      def initialize(season, student)
        @season  = season
        @student = student
      end

      def allowed?
        season_has_status_selection? && student_test_task_done? && !student_has_interview?
      end

      private

      attr_reader :season, :student

      def season_has_status_selection?
        season.status.to_sym == Courses::Season::SELECTION
      end

      def student_test_task_done?
        student&.test_task_done?
      end

      def student_has_interview?
        Courses::Interview.find_by(student: student)
      end
    end
  end
end
