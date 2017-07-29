module Courses
  class Student < ApplicationRecord
    class PassedSeason < ApplicationFinder
      def initialize(season)
        @season = season
      end

      def call
        @season.students.graduated.includes(:user)
      end
    end
  end
end
