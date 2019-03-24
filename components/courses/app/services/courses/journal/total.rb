# frozen_string_literal: true

module Courses
  module Journal
    class Total < ApplicationService
      def initialize(student)
        @student = student
      end

      def call
        total
      end

      private

      attr_reader :student

      def marks_total
        marks.inject { |sum, mark| sum + mark }
      end

      def presences_total
        presences.inject { |sum, presence| sum + presence }
      end

      def total
        marks_total + presences_total if marks_total && presences_total
      end

      def progresses
        @progresses ||= student.progresses
      end

      def marks
        progresses.map(&:homework_mark).compact
      end

      def presences
        progresses.map(&:lecture_presence).compact
      end
    end
  end
end
