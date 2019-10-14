# frozen_string_literal: true

module Courses
  class Interview < ApplicationRecord
    include ApplicationHelper

    attr_accessor :assessments_count, :average_assessment

    self.table_name = 'courses_interviews'

    belongs_to :mentor
    belongs_to :student, optional: true

    has_many :interview_assessments

    enum status: %i[vacant pending completed missed]

    validates :start_at,   presence: true
    validates :student_id, uniqueness: true, allow_nil: true

    delegate :full_name, to: :student, allow_nil: true
    delegate :email,     to: :student, allow_nil: true

    scope :attendance_available, -> { where(student_id: nil) }

    ALLOWED_INTERVAL = 30

    def mentor_name
      mentor.full_name
    end

    def title
      I18n.t 'courses_season_interviews.singular'
    end
  end
end
