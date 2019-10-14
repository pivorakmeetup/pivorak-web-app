# frozen_string_literal: true

module Courses
  module Journal
    class StudentMarkForLecture < ApplicationFinder
      def initialize(student, lecture)
        @student = student
        @lecture = lecture
      end

      def call
        mark
      end

      private

      attr_reader :student, :lecture

      def progresses
        @progresses ||= lecture.progresses.find_by(student_id: student.id)
      end

      def mark
        progresses&.homework_mark
      end
    end
  end
end
