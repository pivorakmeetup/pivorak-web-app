class CreateVisitRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :visit_requests do |t|
      t.integer :event_id
      t.integer :user_id
      t.string :status

      t.timestamps
    end
  end
end
