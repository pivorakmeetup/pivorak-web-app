class CreatePages < ActiveRecord::Migration[5.0]
  def change
    create_table :pages do |t|
      t.string :title
      t.string :url
      t.text :body

      t.timestamps
    end
  end
end
