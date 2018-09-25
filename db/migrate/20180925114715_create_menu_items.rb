class CreateMenuItems < ActiveRecord::Migration[5.2]
  def change
    create_table :menu_items do |t|
      t.string :label
      t.string :href
      t.integer :order

      t.timestamps
    end
  end
end
