class ChangeHomeworkMarkToBeFloatInProgresses < ActiveRecord::Migration[5.0]
  def change
      change_column :courses_progress, :homework_mark, :float
  end
end
