# frozen_string_literal: true

module Courses
  class Interview < ApplicationRecord
    class WithAssessments < ApplicationService
      DEFAULT_VALUE = 0.0

      def initialize(interviews, questions)
        @interviews = interviews
        @questions  = questions
      end

      def call
        interviews.map do |interview|
          interview.assessments_count = mentors_count(interview)
          interview.average_assessment = average_assessment(interview)

          interview
        end
      end

      private

      attr_reader :interviews, :questions

      def assessments(interview)
        Courses::Assessment.where(interview_assessment: interview.interview_assessments)
      end

      def assessments_count(interview)
        assessments(interview).count
      end

      def mentors_count(interview)
        interview.interview_assessments.select(:mentor_id).distinct.count
      end

      def total(interview)
        sum = 0.0

        assessments(interview).each do |assessment|
          sum += assessment.mark
        end

        sum
      end

      def average_assessment(interview)
        if assessments_count(interview).zero?
          DEFAULT_VALUE
        else
          (total(interview) / assessments_count(interview)).round(2)
        end
      end
    end
  end
end
