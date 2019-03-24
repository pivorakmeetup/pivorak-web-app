# frozen_string_literal: true

class AddAdditionalLimitationsToEvents < ActiveRecord::Migration[5.0]
  def change
    remove_column :events, :limitation, :integer

    add_column :events, :limit_total,    :integer, null: false, default: 0
    add_column :events, :limit_verified, :integer, null: false, default: 0
  end
end
