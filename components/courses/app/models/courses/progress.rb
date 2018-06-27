module Courses
  class Progress < ApplicationRecord
    self.table_name = 'courses_progress'

    belongs_to :student
    belongs_to :lecture
    belongs_to :mentor
    belongs_to :homework

    ALLOWED_MARKS = [nil, -1, 0, 0.5, 1, 1.5, 2]

    validates :homework_mark, inclusion: { in: ALLOWED_MARKS }
  end
end
