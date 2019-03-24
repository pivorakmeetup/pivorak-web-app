# frozen_string_literal: true

module Courses
  module HomeworkHelper
    def homework_value_id(lecture, word)
      "l#{lecture.id}_#{word}"
    end
  end
end
