# frozen_string_literal: true

module Courses
  class Note < ApplicationRecord
    belongs_to :notable, polymorphic: true
  end
end
