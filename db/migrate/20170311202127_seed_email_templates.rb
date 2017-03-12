class SeedEmailTemplates < ActiveRecord::Migration[5.0]
  def up
    EmailTemplate.create!(name: "UserMailer#reset_password_instructions", body: File.read('app/views/users/mailer/reset_password_instructions.html.slim'))
    EmailTemplate.create!(name: "UserMailer#confirmation_instructions", body: File.read('app/views/users/mailer/confirmation_instructions.html.slim'))
    EmailTemplate.create!(name: "VisitRequestMailer#unverified_attendee", body: File.read('app/views/mailers/visit_request_mailer/unverified_attendee.slim'), subject: I18n.t('mailers.visit_request_mailer.unverified_attendee.subject'))
    EmailTemplate.create!(name: "VisitRequestMailer#confirmation", body: File.read('app/views/mailers/visit_request_mailer/confirmation.slim'))
    EmailTemplate.create!(name: "VisitRequestMailer#approved", body: File.read('app/views/mailers/visit_request_mailer/approved.slim'))
  end

  def down
    EmailTemplate.delete_all
  end
end
