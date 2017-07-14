module Courses
  class Student < ApplicationRecord
    self.table_name = 'courses_students'

    belongs_to :season
    belongs_to :user
    has_one :interview

    delegate :full_name, to: :user

    enum status: %i[enrolled test_task_done interviewing attending dropped graduated]

    validates :personal_info, presence: true
    validates :motivation_info, presence: true
    validates :user_id, uniqueness: { scope: :season_id }
  end
end
