class CreateCoursesAssessments < ActiveRecord::Migration[5.0]
  def change
    create_table :courses_assessments do |t|
      t.references :interview_assessment
      t.references :question
      t.integer :mark

      t.timestamps
    end
  end
end
