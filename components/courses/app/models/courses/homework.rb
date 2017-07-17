module Courses
  class Homework < ApplicationRecord
    self.table_name = 'courses_homeworks'

    belongs_to :student

    validates :git_url, presence: true
    validates :description, presence: true
  end
end
