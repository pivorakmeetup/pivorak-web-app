class AddStatusToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :status, :integer, default: 0, index: true
  end
end
