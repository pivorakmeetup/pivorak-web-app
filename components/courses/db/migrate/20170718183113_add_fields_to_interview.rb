class AddFieldsToInterview < ActiveRecord::Migration[5.0]
  def change
    add_reference :courses_interviews, :season, index: false
  end
end
