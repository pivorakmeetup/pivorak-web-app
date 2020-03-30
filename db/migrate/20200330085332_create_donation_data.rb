class CreateDonationData < ActiveRecord::Migration[5.2]
  def change
    create_table :donation_data do |t|
      t.string :order_reference
      t.timestamps null: false
    end

    add_index :donation_data, :order_reference, unique: true
  end
end
