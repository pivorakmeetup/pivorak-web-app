class AuthenticationRenameUsersTable < ActiveRecord::Migration[5.0]
  def change
    rename_table :users, :authentication_users
  end
end
