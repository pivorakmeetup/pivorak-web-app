class AddUniqIndexToPagesUrl < ActiveRecord::Migration[5.2]
  def change
    add_index :pages, :url, unique: true
  end
end
