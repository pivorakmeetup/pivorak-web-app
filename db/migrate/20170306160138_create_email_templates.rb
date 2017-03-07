class CreateEmailTemplates < ActiveRecord::Migration[5.0]
  def change
    create_table :email_templates do |t|
      t.string "name"
      t.string "subject"
      t.string "from"
      t.text   "body"
      t.text   "template"

      t.timestamps
    end
  end
end
