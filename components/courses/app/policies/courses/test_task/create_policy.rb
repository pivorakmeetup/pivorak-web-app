# frozen_string_literal: true

module Courses
  class TestTask < ApplicationRecord
    class CreatePolicy
      def initialize(student, season)
        @student_id = student
        @season = season
      end

      def allowed?
        no_test_tasks?
      end

      private

      attr_reader :student_id, :season

      def no_test_tasks?
        !season.test_tasks.exists?(student_id: student_id)
      end
    end
  end
end
