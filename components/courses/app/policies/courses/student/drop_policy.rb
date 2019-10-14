# frozen_string_literal: true

module Courses
  class Student < ApplicationRecord
    class DropPolicy
      DROP_POINT = -3

      def initialize(student, total)
        @student = student
        @total   = total
      end

      def allowed?
        beyond_drop_point? && !student.dropped? && !student.graduated?
      end

      private

      attr_reader :student, :total

      def beyond_drop_point?
        total <= DROP_POINT unless total.nil?
      end
    end
  end
end
