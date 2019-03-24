# frozen_string_literal: true

class AddStatusToCoursesSeasons < ActiveRecord::Migration[5.0]
  def up
    add_column :courses_seasons, :status, :integer, default: 0
  end

  def down
    remove_column :courses_seasons, :status, :integer
  end
end
