module Courses
  class Mentor < ApplicationRecord
    class AvailableForMentoring < ApplicationFinder
      def initialize(season)
        @season = season
      end

      def call
        existing_mentors_user_ids = ::Courses::Mentor.where(season_id: @season).pluck(:user_id)
        User.where.not(id: existing_mentors_user_ids)
      end
    end
  end
end
