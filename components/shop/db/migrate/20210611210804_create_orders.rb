# frozen_string_literal: true

class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :shop_orders do |t|
      t.integer :status, default: 0
      t.text :shipment_address
    end
  end
end
