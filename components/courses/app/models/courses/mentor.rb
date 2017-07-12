module Courses
  class Mentor < ApplicationRecord
    self.table_name = 'season_mentors'

    belongs_to :season
    belongs_to :user

    delegate :full_name, to: :user

    validates :user_id, presence: true, uniqueness: { scope: :season_id }
  end
end
