# frozen_string_literal: true

class CreateEmailTemplates < ActiveRecord::Migration[5.0]
  def change
    create_table :email_templates do |t|
      t.string 'title'
      t.string 'subject'
      t.text   'body'

      t.timestamps
    end
  end
end
