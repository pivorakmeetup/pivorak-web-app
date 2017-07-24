module Courses
  class Interview < ApplicationRecord
    class AssessmentsHash < ApplicationService
      DEFAULT_VALUE = 0.0

      def initialize(interviews, questions)
        @interviews = interviews
        @questions  = questions
        @assessments_hash = Hash.new
      end

      def call
        interviews.each do |interview|
          assessment = { count: mentors_count(interview), average: average_assessment(interview) }
          assessments_hash.merge!(interview => assessment)
        end
        assessments_hash
      end

      private

      attr_reader :interviews, :questions, :assessments_hash

      def assessments_count(interview)
        interview.interview_assessments.count
      end

      def mentors_count(interview)
        interview.interview_assessments.select(:mentor_id).distinct.count
      end

      def total(interview)
        total = interview.interview_assessments.inject(0.0) do |sum, assessment|
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
