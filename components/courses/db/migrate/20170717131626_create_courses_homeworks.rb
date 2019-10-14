# frozen_string_literal: true

class CreateCoursesHomeworks < ActiveRecord::Migration[5.0]
  def change
    create_table :courses_homeworks do |t|
      t.integer :student_id
      t.string :git_url
      t.string :showcase_url
      t.text :description

      t.timestamps
    end
    add_index :courses_homeworks, :student_id
  end
end
