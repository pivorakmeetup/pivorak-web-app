class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :title
      t.string :slug, index: true
      t.text :description
      t.text :agenda
      t.datetime :started_at
      t.datetime :finished_at

      t.timestamps
    end
  end
end
