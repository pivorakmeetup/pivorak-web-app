class AddNotesToCoursesStudents < ActiveRecord::Migration[5.0]
  def change
    add_column :courses_students, :notes, :text
  end
end
