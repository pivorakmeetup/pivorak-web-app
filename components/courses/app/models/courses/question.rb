module Courses
  class Question < ApplicationRecord
    self.table_name = 'courses_questions'

    belongs_to :season

    validates :body, presence: true
  end
end
