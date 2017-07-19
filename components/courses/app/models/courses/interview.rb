module Courses
  class Interview < ApplicationRecord
    include ApplicationHelper

    self.table_name = 'courses_interviews'

    belongs_to :mentor
    belongs_to :student, optional: true

    validates :start_at, presence: true
    validate  :interval_policy
    validates :student_id, uniqueness: true, allow_nil: true

    delegate :full_name, to: :student, allow_nil: true

    ALLOWED_INTERVAL = 30

    def interval_policy
      unless Courses::Interview::IntervalPolicy.new(mentor, self, ALLOWED_INTERVAL).allowed?
        errors.add(:start_at, "should be at least #{ALLOWED_INTERVAL} minutes between interviews")
      end
    end

    def mentor_name
      mentor.full_name
    end

    def title
      I18n.t 'courses_season_interviews.singular'
    end
  end
end
