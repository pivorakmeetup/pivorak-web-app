class CreateMentors < ActiveRecord::Migration[5.0]
  def change
    create_table :season_mentors do |t|
      t.references :user
      t.references :season, references: :courses_season
    end
  end
end
