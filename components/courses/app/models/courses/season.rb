module Courses
  class Season < ApplicationRecord
    self.table_name = 'courses_seasons'

    extend FriendlyId
    friendly_id :title, use: :slugged

    validates :title, presence: true
  end
end
