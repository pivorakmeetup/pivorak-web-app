module Courses
  class Student < ApplicationRecord
    class TotalHash < ApplicationService
      def initialize(students)
        @students   = students
      end

      def call
        students.each_with_object({}) do |student, total_hash|
          total_hash.merge!(student => total(student))
        end
      end

      private

      attr_reader :students

      def total(student)
        ::Courses::Journal::Total.call(student)
      end
    end
  end
end
