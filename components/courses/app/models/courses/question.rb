# frozen_string_literal: true

module Courses
  class Question < ApplicationRecord
    self.table_name = 'courses_questions'

    belongs_to :season

    has_many :assessments

    validates :body, presence: true
  end
end
