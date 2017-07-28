module Courses
  class Assessment < ApplicationRecord
    self.table_name = 'courses_assessments'

    belongs_to :interview_assessment, inverse_of: :assessments
    belongs_to :question

    RANGE = 1..5

    validates :mark, inclusion: { in: RANGE }
  end
end
