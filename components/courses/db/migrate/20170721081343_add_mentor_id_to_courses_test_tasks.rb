# frozen_string_literal: true

class AddMentorIdToCoursesTestTasks < ActiveRecord::Migration[5.0]
  def change
    add_column :courses_test_tasks, :mentor_id, :integer
  end
end
