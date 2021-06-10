# frozen_string_literal: true

class CreateItemImages < ActiveRecord::Migration[5.2]
  def change
    create_table :shop_item_images do |t|
      t.string :image
      t.references :item

      t.timestamps
    end
  end
end
