class CreateCoursesInterviewAssessments < ActiveRecord::Migration[5.0]
  def change
    create_table :courses_interview_assessments do |t|
      t.integer :interview_id
      t.integer :mentor_id
      t.integer :question_id
      t.integer :mark

      t.timestamps
    end

    add_index :courses_interview_assessments, :interview_id
  end
end
