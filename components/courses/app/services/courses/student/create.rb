# frozen_string_literal: true

module Courses
  class Student
    class Create
      def self.call(*args)
        new(*args).call
      end

      def initialize(student_params, season, user_id)
        @student_params = student_params
        @season = season
        @user_id = user_id
      end

      def call
        @student = ::Courses::Student.new(student_params)
        @student.season = season
        @student.user_id = user_id
        @student.status = Courses::Student::ATTENDING if season.open_format?
        @student
      end

      private

      attr_reader :student_params, :season, :user_id
    end
  end
end
