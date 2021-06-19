class AddOpenFormatToCourses < ActiveRecord::Migration[5.2]
  def change
    add_column :courses_seasons, :open_format, :boolean, default: false
  end
end
