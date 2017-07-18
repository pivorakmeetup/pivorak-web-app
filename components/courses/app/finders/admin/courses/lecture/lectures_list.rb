module Admin
  module Courses
    module Lecture
      class LecturesList < ApplicationFinder
        def initialize(season)
          @season = season
        end

        def call
          ::Courses::Lecture.includes(mentor: :user)
                            .includes(:venue)
                            .where(season_id: @season.id)
        end
      end
    end
  end
end
