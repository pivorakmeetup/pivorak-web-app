# frozen_string_literal: true

class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :shop_items do |t|
      t.string :name, null: false
      t.text :description
      t.decimal :price, null: false
      t.integer :available_qty, null: false, default: 0
      t.boolean :published, default: false

      t.timestamps
    end
  end
end
