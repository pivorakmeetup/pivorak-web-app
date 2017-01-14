class CreateFriends < ActiveRecord::Migration[5.0]
  def change
    create_table :friends do |t|
      t.string :name
      t.integer :group_id
      t.string :logo
      t.string :link
      t.text :description

      t.timestamps
    end
  end
end
