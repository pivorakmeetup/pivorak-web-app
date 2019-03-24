# frozen_string_literal: true

class AddCoverToMembers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :cover, :string
  end
end
