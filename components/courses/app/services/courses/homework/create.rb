module Courses
  class Homework
    class Create
      def self.call(*args)
        new(*args).call
      end

      def initialize(homework_params, student_id)
        @homework_params = homework_params
        @student_id = student_id
      end

      def call
        @homework = ::Courses::Homework.new(homework_params)
        @homework.student_id = student_id
        @homework
      end

      private

      attr_reader :homework_params, :student_id
    end
  end
end
