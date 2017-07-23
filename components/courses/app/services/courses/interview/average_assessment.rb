module Courses
  class Interview < ApplicationRecord
    class AverageAssessment < ApplicationService
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

      def assessments
        interview.interview_assessments
      end

      def question_average_mark(question)
        marks = assessments.where(question_id: question).map(&:mark)
        if marks.any?
          ( marks.inject(:+).to_f / marks.size ).round(2)
        else
          0
        end
      end

    end
  end
end
