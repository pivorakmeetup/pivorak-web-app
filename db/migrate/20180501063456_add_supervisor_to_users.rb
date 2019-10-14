# frozen_string_literal: true

class AddSupervisorToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :supervisor, :boolean, default: false
  end
end
