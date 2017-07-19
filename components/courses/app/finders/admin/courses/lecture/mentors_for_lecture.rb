module Admin
  module Courses
    module Lecture
      class MentorsForLecture < ApplicationFinder
        def initialize(season)
          @season = season
        end

        def call
          ::Courses::Mentor.includes(:user).where(season_id: @season.id)
        end
      end
    end
  end
end
