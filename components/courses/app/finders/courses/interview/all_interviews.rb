module Courses
  class Interview < ApplicationRecord
    class AllInterviews < ApplicationFinder
      def initialize(season)
        @season = season
      end

      def call
        base_scope = season_interviews
          .includes(mentor: :user)
          .includes(student: :user)

        @interviews ||= if assessments?
          base_scope.includes(:interview_assessments)
        else
          base_scope
        end
      end

      private

      attr_reader :season

      def assessments?
        season_interviews.select { |interview|
          interview.interview_assessments.exists?
        }.any?
      end

      def season_interviews
        @season_interviews ||= season.interviews
      end
    end
  end
end
