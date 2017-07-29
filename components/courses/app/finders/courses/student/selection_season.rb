module Courses
  class Student < ApplicationRecord
    class SelectionSeason < ApplicationFinder
      def initialize(season)
        @season = season
      end

      def call
        @season.students.where(status: %i[test_task_done interviewing]).includes(:user)
      end
    end
  end
end
