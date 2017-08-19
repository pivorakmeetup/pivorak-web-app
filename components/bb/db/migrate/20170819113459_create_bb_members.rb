class CreateBbMembers < ActiveRecord::Migration[5.0]
  def change
    create_table :bb_members do |t|
      t.integer :user_id
      t.integer :status
      t.datetime :membered_at
    end
    add_index :bb_members, :user_id
    add_index :bb_members, :status
  end
end
