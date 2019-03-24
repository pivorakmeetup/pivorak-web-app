# frozen_string_literal: true

class AddSlugToGroups < ActiveRecord::Migration[5.2]
  def change
    add_column :groups, :slug, :string

    Group.all.each(&:save!)
  end
end
