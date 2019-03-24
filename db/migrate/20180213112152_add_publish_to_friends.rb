# frozen_string_literal: true

class AddPublishToFriends < ActiveRecord::Migration[5.0]
  def change
    add_column :friends, :published, :boolean, default: false
  end
end
