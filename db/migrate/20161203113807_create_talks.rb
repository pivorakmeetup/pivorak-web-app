class CreateTalks < ActiveRecord::Migration[5.0]
  def change
    create_table :talks do |t|
      t.string  :title
      t.string  :slug, index: true
      t.text    :description
      t.string  :video_url
      t.string  :slides_url
      t.integer :event_id,   index: true
      t.integer :speaker_id, index: true

      t.timestamps
    end
  end
end
