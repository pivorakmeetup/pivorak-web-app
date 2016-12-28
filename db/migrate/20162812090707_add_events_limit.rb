class AddEventsLimit < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :limitation, :integer, default: Event::DEFAULT_LIMIT
  end
end
