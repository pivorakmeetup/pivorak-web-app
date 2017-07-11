module Courses
  class Mentor < ApplicationRecord
    self.table_name = 'season_mentors'

    belongs_to :season
    belongs_to :user
  end
end
