module Courses
  class Progress < ApplicationRecord
    self.table_name = 'courses_progress'

    belongs_to :student
    belongs_to :lecture
    belongs_to :mentor
    belongs_to :homework
  end
end
