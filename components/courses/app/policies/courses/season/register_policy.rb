module Courses
  class Season < ApplicationRecord
    class RegisterPolicy
      def initialize(season, student)
        @season  = season
        @student = student
      end

      def allowed?
        season_has_status_registration? &&
          !student_enrolled? &&
          !student_test_task_done?
      end

      private

      attr_reader :season, :student

      def season_has_status_registration?
        season.status.to_sym == Courses::Season::REGISTRATION
      end

      def student_enrolled?
        student&.enrolled?
      end

      def student_test_task_done?
        student&.test_task_done?
      end
    end
  end
end
