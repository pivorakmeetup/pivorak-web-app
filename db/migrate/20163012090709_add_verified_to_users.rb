class AddVerifiedToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :verified, :boolean, default: false
  end
end
