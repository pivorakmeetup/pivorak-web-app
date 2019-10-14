# frozen_string_literal: true

module Courses
  class TestTask < ApplicationRecord
    class Create < ApplicationService
      def initialize(test_task_params, student_id)
        @test_task_params = test_task_params
        @student_id = student_id
      end

      def call
        ::Courses::TestTask.new(
          test_task_params.merge(student_id: student_id)
        )
      end

      private

      attr_reader :test_task_params, :student_id
    end
  end
end
