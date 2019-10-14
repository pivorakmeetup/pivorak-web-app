# frozen_string_literal: true

module Courses
  class Homework < ApplicationRecord
    class Create < ApplicationService
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
