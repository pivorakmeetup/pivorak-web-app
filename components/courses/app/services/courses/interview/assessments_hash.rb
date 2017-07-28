module Courses
  class Interview < ApplicationRecord
    class AssessmentsHash < ApplicationService
      DEFAULT_VALUE = 0.0

      def initialize(interviews, questions)
        @interviews = interviews
        @questions  = questions
      end

      def call
        interviews.each_with_object({}) do |interview, assessments_hash|
          assessment = { count: mentors_count(interview), average: average_assessment(interview) }
          assessments_hash.merge!(interview => assessment)
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
        assessments(interview).inject(0.0) do |sum, assessment|
          sum += assessment.mark
        end
      end

      def average_assessment(interview)
        if assessments_count(interview).zero?
          DEFAULT_VALUE
        else
          (total(interview)/assessments_count(interview)).round(2)
        end
      end
    end
  end
end
