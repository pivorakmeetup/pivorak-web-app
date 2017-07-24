module Courses
  class TestTask < ApplicationRecord
    class Update < ApplicationService
      def initialize(test_task, mentor)
        @test_task = test_task
        @mentor    = mentor
      end

      def call
        transaction do
          test_task.update(mentor_id: mentor.id)
          
          student.test_task_done!
        end
      end

      private

      attr_reader :test_task, :mentor

      delegate :student, to: :test_task
    end
  end
end
