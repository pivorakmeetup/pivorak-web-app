# frozen_string_literal: true

module Courses
  class InterviewAssessment < ApplicationRecord
    self.table_name = 'courses_interview_assessments'

    belongs_to :interview
    belongs_to :mentor

    has_many :assessments, inverse_of: :interview_assessment

    accepts_nested_attributes_for :assessments, allow_destroy: true
  end
end
