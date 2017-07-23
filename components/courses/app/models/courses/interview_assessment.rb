module Courses
  class InterviewAssessment < ApplicationRecord
    self.table_name = 'courses_interview_assessments'

    belongs_to :interview
    belongs_to :mentor
    belongs_to :question

    RANGE = 1..5

    validates :mark, inclusion: { in: RANGE }
  end
end
