# frozen_string_literal: true

module Courses
  class Student
    class Drop < ApplicationService
      def initialize(student)
        @student = student
      end

      def call
        student.dropped!
      end

      private

      attr_reader :student
    end
  end
end
