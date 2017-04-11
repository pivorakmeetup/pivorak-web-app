class AuthorizationCreateUsersTable < ActiveRecord::Migration[5.0]
  def change
    create_table :authorization_users do |t|
      t.integer :user_id,   null: false
      t.boolean :admin,     null: false, default: false
      t.boolean :verified,  null: false, default: false
      t.boolean :synthetic, null: false, default: false

      t.timestamps

      t.index :user_id
    end
  end
end
