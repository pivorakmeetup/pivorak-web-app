# frozen_string_literal: true

class AddStatusToTestTasks < ActiveRecord::Migration[5.0]
  def change
    add_column :courses_test_tasks, :status, :integer, default: 0, index: true
  end
end
