class AddCurrencyToDonation < ActiveRecord::Migration[5.0]
  def change
    add_column :donations, :currency, :string, default: 'UAH'
  end
end
