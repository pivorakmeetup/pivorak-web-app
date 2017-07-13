class CreateCoursesInterviews < ActiveRecord::Migration[5.0]
  def change
    create_table :courses_interviews do |t|
      t.integer  :season_id
      t.integer  :mentor_id
      t.integer  :student_id
      t.datetime :start_at
      t.text     :description

      t.timestamps
    end
  end
end
