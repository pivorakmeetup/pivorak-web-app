module Courses
  module Journal
    class Total < ApplicationService
      def initialize(student)
        @student   = student
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
        if marks_total && presences_total
          marks_total + presences_total
        else
          nil
        end
      end

      def progresses
        @progresses ||= student.progresses
      end

      def marks
        progresses.map{ |progress| progress.homework_mark }.compact
      end

      def presences
        progresses.map{ |progress| progress.lecture_presence }.compact
      end
    end
  end
end
