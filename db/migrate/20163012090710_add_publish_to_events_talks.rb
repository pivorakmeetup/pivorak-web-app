# frozen_string_literal: true

class AddPublishToEventsTalks < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :published, :boolean, default: false
    add_column :talks,  :published, :boolean, default: false
  end
end
