# frozen_string_literal: true

module Courses
  class Student < ApplicationRecord
    self.table_name = 'courses_students'

    belongs_to :season
    belongs_to :user
    has_one    :interview
    has_one    :test_task
    has_many   :homeworks
    has_many   :progresses
    has_many   :notes, as: :notable

    delegate :full_name, to: :user
    delegate :email,     to: :user

    ENROLLED       = :enrolled
    TEST_TASK_DONE = :test_task_done
    INTERVIEWING   = :interviewing
    ATTENDING      = :attending
    DROPPED        = :dropped
    GRADUATED      = :graduated
    REFUSED        = :refused

    enum status: [ENROLLED, TEST_TASK_DONE, INTERVIEWING, ATTENDING, DROPPED, GRADUATED, REFUSED]

    validates :personal_info,   presence: true
    validates :motivation_info, presence: true
    validates :experience_info, presence: true
    validates :devote_info,     presence: true
    validates :user_id,         uniqueness: { scope: :season_id }
  end
end
