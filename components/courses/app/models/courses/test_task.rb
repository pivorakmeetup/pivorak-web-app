# frozen_string_literal: true

module Courses
  class TestTask < ApplicationRecord
    self.table_name = 'courses_test_tasks'

    SUBMITED       = :submited
    ON_REVIEW      = :on_review
    APPROVED       = :approved

    enum status: [SUBMITED, ON_REVIEW, APPROVED]

    belongs_to :student
    belongs_to :season
    belongs_to :mentor

    validates :git_url, presence: true
    validates :student_id, uniqueness: true

    delegate :season_id, to: :student
    delegate :full_name, to: :student
  end
end
