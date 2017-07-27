class RemoveMarkAndQuestionFromCoursesInterviewAssessments < ActiveRecord::Migration[5.0]
  def change
    remove_column :courses_interview_assessments, :mark, :integer
    remove_column :courses_interview_assessments, :question_id, :integer
  end
end
