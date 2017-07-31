module Courses
  class Interview < ApplicationRecord
    class AllInterviews < ApplicationFinder
      def initialize(season)
        @season = season
      end

      def call
        return base_scope unless assessments?

        base_scope.includes(:interview_assessments)
      end

      private

      attr_reader :season

      def base_scope
        @base_scope ||= season_interviews
          .includes(mentor: :user)
          .includes(student: :user)
      end

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
