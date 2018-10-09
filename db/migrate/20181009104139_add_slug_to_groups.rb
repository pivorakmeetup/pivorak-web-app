class AddSlugToGroups < ActiveRecord::Migration[5.2]
  def change
    add_column :groups, :slug, :string

    Group.all.each do |group|
      group.save!
    end
  end
end
