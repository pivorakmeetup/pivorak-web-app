class CreateBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :bb_books do |t|
      t.string :title
      t.text :description
      t.integer :member_id
      t.integer :status, default: 0
    end
    add_index :bb_books, :member_id
    add_index :bb_books, :status
  end
end
