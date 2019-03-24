# frozen_string_literal: true

class CreateEmails < ActiveRecord::Migration[5.0]
  def change
    create_table :emails do |t|
      t.string :subject
      t.string :body

      t.timestamps
    end
  end
end
