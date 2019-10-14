# frozen_string_literal: true

class AddAdminToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :admin, :boolean, default: true
  end
end
