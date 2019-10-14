# frozen_string_literal: true

module Courses
  class Student < ApplicationRecord
    class AttendingAndGraduated < ApplicationFinder
      def initialize(season, included = nil)
        @season   = season
        @included = included
      end

      def call
        attending + graduated
      end

      private

      attr_reader :season, :included

      def attending
        season.students.attending.includes(included)
      end

      def graduated
        season.students.graduated.includes(included)
      end
    end
  end
end
