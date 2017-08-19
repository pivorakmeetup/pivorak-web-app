module Courses
  class Interview < ApplicationRecord
    class Update < ApplicationService
      def initialize(interview, student)
        @interview = interview
        @student   = student
      end

      def call
        transaction do
          interview.update(student_id: student.id, status: :pending)

          student.interviewing!
        end
      end

      private

      attr_reader :interview, :student
    end
  end
end
