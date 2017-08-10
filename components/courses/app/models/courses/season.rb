module Courses
  class Season < ApplicationRecord
    self.table_name = 'courses_seasons'

    extend FriendlyId
    friendly_id :title, use: :slugged

    has_many :mentors
    has_many :questions
    has_many :interviews, through: :mentors
    has_many :students
    has_many :lectures
    has_many :test_tasks, through: :students

    PLANNED       = :planned
    REGISTRATION  = :registration
    SELECTION     = :selection
    LIVE          = :live
    PASSED        = :passed

    enum status: [PLANNED, REGISTRATION, SELECTION, LIVE, PASSED]

    validates :title, presence: true
    validate  :time_policy

    def time_policy
      return if Courses::Season::TimePolicy.new(self).allowed?
      errors.add(:finish_at, 'must be after start time!')
    end
  end
end
