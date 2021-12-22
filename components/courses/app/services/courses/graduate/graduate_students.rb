# frozen_string_literal: true

module Courses
  module Graduate
    class GraduateStudents < ApplicationService
      def initialize(season)
        @season = season
      end

      def call
        season.students.attending.update(status: :graduated)
      end

      private

      attr_reader :season
    end
  end
end
