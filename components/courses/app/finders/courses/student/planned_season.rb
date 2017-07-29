module Courses
  class Student < ApplicationRecord
    class PlannedSeason < ApplicationFinder
      EMPTY_ARRAY = []

      def initialize(season)
        @season = season
      end

      def call
        EMPTY_ARRAY
      end
    end
  end
end
