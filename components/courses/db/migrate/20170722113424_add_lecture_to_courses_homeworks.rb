# frozen_string_literal: true

class AddLectureToCoursesHomeworks < ActiveRecord::Migration[5.0]
  def change
    add_reference :courses_homeworks, :lecture
  end
end
