# frozen_string_literal: true

class AddExtraToTalks < ActiveRecord::Migration[5.0]
  def change
    add_column :talks, :extra, :jsonb, default: {}
  end
end
