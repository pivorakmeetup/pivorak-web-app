class CreateLectures < ActiveRecord::Migration[5.0]
  def change
    create_table :courses_lectures do |t|
      t.string :title
      t.string :slug, index: true
      t.text :description
      t.datetime :started_at
      t.datetime :finished_at
      t.integer :status
      t.references :venue
      t.references :season
      t.references :mentor
    end
  end
end
