class CreateDonations < ActiveRecord::Migration[5.0]
  def change
    create_table :donations do |t|
      t.references :user, index: true
      t.references :goal, index: true

      t.decimal    :amount, precision: 10, scale: 2

      t.timestamps
    end
  end
end
