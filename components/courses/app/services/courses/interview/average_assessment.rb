module Courses
  class Interview < ApplicationRecord
    class AverageAssessment < ApplicationService
      ZERO_MARK = 0

      def initialize(interview, questions)
        @interview = interview
        @questions = questions
      end

      def call
        @questions.map do |question|
          question_params(question)
        end
      end

      private

      attr_reader :interview

      def question_params(question)
        { 
          question: question.body,
          mark:     question_average_mark(question)
        }
      end

      def interview_assessments
        interview.interview_assessments
      end

      def question_average_mark(question)
        marks = Courses::Assessment.where(interview_assessment: interview_assessments, question: question).map(&:mark)
        if marks.any?
          ( marks.inject(:+).to_f / marks.size ).round(2)
        else
          ZERO_MARK
        end
      end

    end
  end
end
