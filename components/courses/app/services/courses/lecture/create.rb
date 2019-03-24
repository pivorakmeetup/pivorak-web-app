# frozen_string_literal: true

module Courses
  class Lecture
    class Create < ApplicationService
      def initialize(lecture)
        @lecture = lecture
      end

      def call
        return unless lecture.valid?

        lecture.save
        ::Courses::Student.attending.each do |student|
          lecture.progresses.create(student: student, mentor: lecture.mentor)
        end
      end

      private

      attr_reader :lecture
    end
  end
end
