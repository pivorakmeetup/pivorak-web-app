# frozen_string_literal: true

class AddCoverToTalks < ActiveRecord::Migration[5.0]
  def change
    add_column :talks, :cover, :string
  end
end
