class ChangeHomeworkMarkInCoursesProgress < ActiveRecord::Migration[5.2]
  def change
    change_column :courses_progress, :homework_mark, :decimal, precision: 4, scale: 2
  end
end
