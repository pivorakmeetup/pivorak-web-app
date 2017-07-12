class CreateCoursesQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :courses_questions do |t|
      t.string   :body
      t.integer  :season_id

      t.timestamps
    end
  end
end
