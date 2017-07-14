module Courses
  class Season < ApplicationRecord
    self.table_name = 'courses_seasons'

    extend FriendlyId
    friendly_id :title, use: :slugged

    has_many :mentors
    has_many :questions
    has_many :interviews, through: :mentors
    has_many :students

    PLANNED       = :planned
    REGISTRATION  = :registration
    SELECTION     = :selection
    LIVE          = :live
    PASSED        = :passed

    enum status: [PLANNED, REGISTRATION, SELECTION, LIVE, PASSED]

    validates :title, presence: true
  end
end
