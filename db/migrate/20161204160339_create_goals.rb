# frozen_string_literal: true

class CreateGoals < ActiveRecord::Migration[5.0]
  def change
    create_table :goals do |t|
      t.string  :title
      t.string  :slug, index: true
      t.text    :description
      t.decimal :amount, precision: 10, scale: 2

      t.timestamps
    end
  end
end
