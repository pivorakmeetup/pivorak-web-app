class AddPaymentIdToDonation < ActiveRecord::Migration[5.0]
  def change
    add_column :donations, :payment_id, :integer

    add_index :donations, :payment_id
  end
end
