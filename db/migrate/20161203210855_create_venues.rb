# frozen_string_literal: true

class CreateVenues < ActiveRecord::Migration[5.0]
  def change
    create_table :venues do |t|
      t.string :name
      t.string :address
      t.string :map_url
      t.string :description
      t.string :slug, index: true

      t.timestamps
    end
  end
end
