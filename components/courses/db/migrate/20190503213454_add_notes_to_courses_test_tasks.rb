# frozen_string_literal: true

class AddNotesToCoursesTestTasks < ActiveRecord::Migration[5.0]
  def change
    add_column :courses_test_tasks, :notes, :text
  end
end
