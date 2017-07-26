module Courses
  module Journal
    class StudentPresenceForLecture < ApplicationFinder
      def initialize(student, lecture)
        @student = student
        @lecture = lecture
      end

      def call
        presence
      end

      private

      attr_reader :student, :lecture

      def progresses
        @progresses ||= lecture.progresses.find_by(student_id: student.id)
      end

      def presence
        if progresses
          progresses.lecture_presence
        else
          nil
        end
      end
    end
  end
end
