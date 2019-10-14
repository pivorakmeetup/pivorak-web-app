# frozen_string_literal: true

module Courses
  class Season < ApplicationRecord
    class GraduateStudentsPolicy
      def initialize(season)
        @season = season
      end

      def allowed?
        season.passed? && attending_students?
      end

      private

      attr_reader :season

      def attending_students?
        season.students.attending.any?
      end
    end
  end
end
