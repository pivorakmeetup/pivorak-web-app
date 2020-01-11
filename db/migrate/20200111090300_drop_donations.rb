class DropDonations < ActiveRecord::Migration[5.2]
  def change
    drop_table :donations
  end
end
