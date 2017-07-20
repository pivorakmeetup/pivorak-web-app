class AddVideoUrlAndStatusToCoursesInterviews < ActiveRecord::Migration[5.0]
  def change
    add_column :courses_interviews, :video_url, :string
    add_column :courses_interviews, :status, :integer, default: 0
  end
end
