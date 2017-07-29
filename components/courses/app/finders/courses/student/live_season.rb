module Courses
  class Student < ApplicationRecord
    class LiveSeason < ApplicationFinder
      def initialize(season)
        @season = season
      end

      def call
        @season.students.attending.includes(:user)
      end
    end
  end
end
