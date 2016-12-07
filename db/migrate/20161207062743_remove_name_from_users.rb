class RemoveNameFromUsers < ActiveRecord::Migration[5.0]
  def up
    remove_column :users, :name
  end

  def down
    add_column :users, :name, :string
  end
end
