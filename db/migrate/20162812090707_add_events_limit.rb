class AddEventsLimit < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :limitation, :integer, default: 50
  end
end
