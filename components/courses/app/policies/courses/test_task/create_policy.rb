module Courses
  class TestTask
    class CreatePolicy
      def initialize(student, season)
        @student = student
        @season = season
      end

      def allowed?
        has_no_test_tasks?
      end

      private

      attr_reader :student, :season

      def has_no_test_tasks?
        !(season.test_tasks.exists?(student_id: student.id))
      end
    end
  end
end
