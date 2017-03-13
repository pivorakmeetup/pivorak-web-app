class AddNoteToEmailTemplates < ActiveRecord::Migration[5.0]
  def change
    add_column :email_templates, :note, :string
  end
end
