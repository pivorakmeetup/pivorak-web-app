class AuthenticationRemoveObsoleteColumns < ActiveRecord::Migration[5.0]
  def up
    remove_column :users, :admin
    remove_column :users, :verified
    remove_column :users, :synthetic
    remove_column :users, :first_name
    remove_column :users, :last_name
    remove_column :users, :slug
    remove_column :users, :cover
  end

  def down
    add_column :users, :admin,      :boolean, default: false
    add_column :users, :verified,   :boolean, default: false
    add_column :users, :synthetic,  :boolean, default: false
    add_column :users, :first_name, :string
    add_column :users, :last_name,  :string
    add_column :users, :slug,       :string
    add_column :users, :cover,      :string

    ActiveRecord::Base.connection.execute <<-SQL
      UPDATE users
      SET
        admin      = authorization_users.admin,
        verified   = authorization_users.verified,
        synthetic  = authorization_users.synthetic,
        first_name = profiling_users.first_name,
        last_name  = profiling_users.last_name,
        slug       = profiling_users.slug,
        cover      = profiling_users.cover
      FROM users as authentication_users
        JOIN authorization_users ON authorization_users.user_id = authentication_users.id
        JOIN profiling_users ON profiling_users.user_id = authentication_users.id
    SQL
  end
end
