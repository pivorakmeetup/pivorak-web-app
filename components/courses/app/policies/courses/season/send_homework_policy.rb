module Courses
  class Season < ApplicationRecord
    class SendHomeworkPolicy
      def initialize(season, student)
        @season  = season
        @student = student
      end

      def allowed?
        season_has_status_live? && !student_is_dropped?
      end

      private

      attr_reader :season, :student

      def season_has_status_live?
        season.status.to_sym == Courses::Season::LIVE
      end

      def student_is_dropped?
        student&.dropped?
      end
    end
  end
end
