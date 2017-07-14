class CreateCoursesStudents < ActiveRecord::Migration[5.0]
  def change
    create_table :courses_students do |t|
      t.integer :user_id
      t.integer :season_id
      t.integer :status, default: 0
      t.text :personal_info
      t.text :motivation_info

      t.timestamps
    end
    add_index :courses_students, :user_id
  end
end
