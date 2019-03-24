# frozen_string_literal: true

module Courses
  class Homework < ApplicationRecord
    class AvailableLectures < ApplicationFinder
      def initialize(season, student)
        @season = season
        @student = student
      end

      def call
        lectures_with_homeworks = season.lectures.includes(:homeworks)
                                        .where(courses_homeworks: { student_id: student.id })
        season.lectures - lectures_with_homeworks
      end

      private

      attr_reader :season, :student
    end
  end
end
