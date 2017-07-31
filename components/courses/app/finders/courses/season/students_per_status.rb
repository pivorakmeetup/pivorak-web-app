module Courses
  class Season < ApplicationRecord
    class StudentsPerStatus < ApplicationFinder
      EMPTY_ARRAY = []

      def initialize(season)
        @season = season
      end

      def call
        case @season.status.to_sym
        when ::Courses::Season::PLANNED
          planned_season_students
        when ::Courses::Season::REGISTRATION
          registration_season_students
        when ::Courses::Season::SELECTION
          selection_season_students
        when ::Courses::Season::LIVE
          live_season_students
        when ::Courses::Season::PASSED
          passed_season_students
        end
      end

      private

      attr_reader :season

      def planned_season_students
        EMPTY_ARRAY
      end

      def registration_season_students
        season.students.enrolled.includes(:user)
      end

      def selection_season_students
        season.students.where(status: %i[test_task_done interviewing]).includes(:user)
      end

      def live_season_students
        season.students.attending.includes(:user).includes(:progresses)
      end

      def passed_season_students
        season.students.graduated.includes(:user)
      end
    end
  end
end
