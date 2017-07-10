class CreateCoursesSeasons < ActiveRecord::Migration[5.0]
  def change
    create_table :courses_seasons do |t|
      t.string   :title
      t.string   :slug, index: true
      t.text     :description
      t.datetime :start_at
      t.datetime :finish_at

      t.timestamps
    end
  end
end
