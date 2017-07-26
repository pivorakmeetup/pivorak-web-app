module Courses
  class TestTask < ApplicationRecord
    self.table_name = 'courses_test_tasks'

    belongs_to :student
    belongs_to :season
    belongs_to :mentor

    validates :git_url, presence: true
    validates :student_id, uniqueness: true

    delegate :season_id, to: :student
    delegate :full_name, to: :student
  end
end
