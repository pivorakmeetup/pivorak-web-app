class AddExperienceInfoToCoursesStudents < ActiveRecord::Migration[5.0]
  def change
    add_column :courses_students, :experience_info, :text
  end
end
