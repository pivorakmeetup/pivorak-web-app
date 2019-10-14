# frozen_string_literal: true

class SeedEmailTemplateVisitRequestPendingConfirmation < ActiveRecord::Migration[5.0]
  def change
    EmailTemplate.create!(
      title:   'VisitRequestMailer#needs_confirmation',
      body:    File.read('db/seed/email_templates/needs_confirmation.md'),
      subject: 'Event registration needs confirmation'
    )
  end
end
