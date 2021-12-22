# frozen_string_literal: true

module Courses
  class Interview < ApplicationRecord
    class InterviewAssessmentForInterview < ApplicationFinder
      def initialize(interview, mentor)
        @interview = interview
        @mentor    = mentor
      end

      def call
        if interview_assessments.exists?(mentor: mentor)
          interview_assessments
            .find_by(mentor: mentor)
        else
          interview_assessments
            .includes(assessments: [:question])
            .new(mentor: mentor)
        end
      end

      private

      attr_reader :interview, :mentor

      def interview_assessments
        @interview_assessments ||= interview.interview_assessments
      end
    end
  end
end
