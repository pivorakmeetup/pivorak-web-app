# frozen_string_literal: true

module Courses
  class Season < ApplicationRecord
    class CancelAttendance < ApplicationService
      def initialize(student)
        @student = student
      end

      def call
        student.refused!
      end

      private

      attr_reader :student
    end
  end
end
