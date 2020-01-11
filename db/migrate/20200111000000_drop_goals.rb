class DropGoals < ActiveRecord::Migration[5.2]
  def change
    drop_table :goals
  end
end
