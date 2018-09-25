class MenuItemReferences < ActiveRecord::Migration[5.2]
  def change
    create_table :menu_items_references do |t|
      t.integer :parent_id
      t.integer :child_id
      t.integer :order
    end
  end
end
