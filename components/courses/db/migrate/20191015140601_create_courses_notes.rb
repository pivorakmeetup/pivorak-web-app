class CreateCoursesNotes < ActiveRecord::Migration[5.2]
  def change
    create_table :courses_notes do |t|
      t.references :notable, polymorphic: true
      t.text :content

      t.timestamps
    end
  end
end
