# frozen_string_literal: true

class CreateProgress < ActiveRecord::Migration[5.0]
  def change
    create_table :courses_progress do |t|
      t.references :student
      t.references :lecture
      t.references :mentor
      t.integer :homework_mark
      t.integer :lecture_presence, default: 0
    end
  end
end
