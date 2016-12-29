class AddGroupIdToTalks < ActiveRecord::Migration[5.0]
  def change
    add_column :talks, :group_id, :integer, index: true
  end
end
