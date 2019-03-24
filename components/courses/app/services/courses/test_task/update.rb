module Courses
  class TestTask < ApplicationRecord
    class Update < ApplicationService
      def initialize(test_task, mentor, status:)
        @test_task = test_task
        @mentor    = mentor
        @status    = status
      end

      def call
        transaction do
          test_task.update(mentor_id: mentor_id, status: status)

          student.test_task_done!
        end
      end

      private

      attr_reader :test_task, :mentor, :status

      delegate :student, to: :test_task

      def mentor_id
        return if  status == Courses::TestTask::SUBMITED

        mentor.id
      end
    end
  end
end
