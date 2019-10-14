# frozen_string_literal: true

class AddDevoteInfoToCoursesStudents < ActiveRecord::Migration[5.0]
  def change
    add_column :courses_students, :devote_info, :text
  end
end
