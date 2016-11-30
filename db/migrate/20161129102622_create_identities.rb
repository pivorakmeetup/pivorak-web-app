class CreateIdentities < ActiveRecord::Migration[5.0]
  def change
    create_table :identities do |t|
      t.string :uid
      t.string :provider
      t.references :user
    end
  end
end
