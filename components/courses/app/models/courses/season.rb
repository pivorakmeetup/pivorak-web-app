module Courses
  class Season < ApplicationRecord
    self.table_name = 'courses_seasons'

    extend FriendlyId
    friendly_id :title, use: :slugged

    has_many :mentors
    has_many :questions

    validates :title, presence: true
  end
end
