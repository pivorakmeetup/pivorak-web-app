class ProfilingCreateUsersTable < ActiveRecord::Migration[5.0]
  def change
    create_table :profiling_users do |t|
      t.integer :user_id,    null: false
      t.string  :email,      null: false
      t.string  :first_name, null: false
      t.string  :last_name,  null: false
      t.string  :slug
      t.string  :cover

      t.timestamps

      t.index :user_id
    end
  end
end
