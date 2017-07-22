module Courses
  class Homework < ApplicationRecord
    self.table_name = 'courses_homeworks'

    belongs_to :student
    belongs_to :lecture

    validates :git_url, :description, :lecture_id, presence: true
  end
end
