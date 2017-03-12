class SeedEmailTemplates < ActiveRecord::Migration[5.0]
  def up
    Rake::Task['email_templates:seed'].execute
  end

  def down
    EmailTemplate.delete_all
  end
end
