# frozen_string_literal: true

module Courses
  class Season < ApplicationRecord
    class TimePolicy
      def initialize(season)
        @season = season
      end

      def allowed?
        season.start_at.nil? || season.finish_at.nil? || time_is_correct?
      end

      private

      attr_reader :season

      def time_is_correct?
        season.start_at < season.finish_at
      end
    end
  end
end
