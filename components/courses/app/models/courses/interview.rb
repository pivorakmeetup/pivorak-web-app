module Courses
  class Interview < ApplicationRecord
    include ApplicationHelper

    self.table_name = 'courses_interviews'

    belongs_to :season
    belongs_to :mentor
    belongs_to :student, optional: true

    validates :start_at, uniqueness: { scope: :mentor_id }, presence: true
    validate  :half_hour_after_previous_interview

    def half_hour_after_previous_interview
      if mentor_has_interview_earlier_than_half_hour_before?
        errors.add(:start_at, "should be at least 30 minutes after your previous interview")
      end
    end

    def mentor_name
      mentor.full_name
    end

    # need to be changed after creating a Student model
    def student_name
      'Smartest student'
    end

    def title
      I18n.t 'courses_season_interviews.singular'
    end

    private

    def mentor_has_interview_earlier_than_half_hour_before?
      interviews = mentor.interviews.where(start_at: start_at-30.minutes..start_at)
      interviews.any? && interviews.exclude?(self)
    end
  end
end
