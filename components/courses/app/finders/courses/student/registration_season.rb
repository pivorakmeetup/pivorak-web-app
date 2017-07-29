module Courses
  class Student < ApplicationRecord
    class RegistrationSeason < ApplicationFinder
      def initialize(season)
        @season = season
      end

      def call
        @season.students.enrolled.includes(:user)
      end
    end
  end
end
