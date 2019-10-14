# frozen_string_literal: true

class CreateCoursesTestTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :courses_test_tasks do |t|
      t.integer :student_id
      t.string :git_url
      t.string :showcase_url
      t.text :comment

      t.timestamps
    end
  end
end
