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
        if progresses
          progresses.homework_mark
        else
          nil
        end
      end
    end
  end
end
