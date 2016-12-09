class AddSyntheticToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :synthetic, :boolean, default: false
  end
end
