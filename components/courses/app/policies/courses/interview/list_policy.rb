module Courses
  class Interview < ApplicationRecord
    class ListPolicy

      def initialize(student, season)
        @student = student
        @season  = season
      end

      def allowed?
        student_belongs_to_the_season && student.test_task_done?
      end

      private

      attr_reader :student, :season

      def student_belongs_to_the_season
        student.season_id == season.id
      end
    end
  end
end
