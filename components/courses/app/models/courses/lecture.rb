module Courses
  class Lecture < ApplicationRecord
    self.table_name = 'courses_lectures'

    extend FriendlyId
    friendly_id :title, use: :slugged

    belongs_to :season
    belongs_to :venue
    belongs_to :mentor
    has_many   :progresses
    has_many   :homeworks

    UPCOMING = :upcoming
    PASSED   = :passed

    enum status: [UPCOMING, PASSED]

    validates :title, :started_at, :finished_at, :venue_id, :mentor_id, presence: true
    validate  :time_policy

    def time_policy
      return if Courses::Lecture::TimePolicy.new(self).allowed?
      errors.add(:finished_at, 'must be after start time!')
    end
  end
end
