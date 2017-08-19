module Courses
  class InterviewAssessment < ApplicationRecord
    class BuildAssessments < ApplicationService
      def initialize(interview_assessment, questions)
        @interview_assessment = interview_assessment
        @questions            = questions
      end

      def call
        return unless @interview_assessment.new_record?

        @questions.each do |question|
          build_assessment_for_question(question)
        end
      end

      private

      attr_reader :interview_assessment

      def build_assessment_for_question(question)
        interview_assessment.assessments.build(question: question)
      end
    end
  end
end
