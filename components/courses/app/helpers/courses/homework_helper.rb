module Courses
  module HomeworkHelper
    def homework_value_id( lecture, word)
      "l#{lecture.id.to_s}_#{word}"
    end
  end
end
