module Courses
  class Student
    class Create
      def self.call(*args)
        new(*args).call
      end

      def initialize(student_params, season_id, user_id)
        @student_params = student_params
        @season_id = season_id
        @user_id = user_id
      end

      def call
        @student = ::Courses::Student.new(student_params)
        @student.season_id = season_id
        @student.user_id = user_id
        @student
      end

      private

      attr_reader :student_params, :season_id, :user_id
    end
  end
end
