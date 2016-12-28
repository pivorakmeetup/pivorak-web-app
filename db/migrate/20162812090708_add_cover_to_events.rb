class AddCoverToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :cover, :string
  end
end
