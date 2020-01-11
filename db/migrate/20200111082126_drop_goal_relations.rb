class DropGoalRelations < ActiveRecord::Migration[5.2]
  def change
    remove_column :donations, :goal_id, :integer
  end
end
