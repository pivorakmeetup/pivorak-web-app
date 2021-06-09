# frozen_string_literal: true

class CreateOrderItems < ActiveRecord::Migration[5.2]
  def change
    create_table :shop_order_items do |t|
      t.integer :quantity, default: 1
      t.decimal :price, null: false
      t.references :item
      t.references :order
    end
  end
end
