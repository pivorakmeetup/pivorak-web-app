# frozen_string_literal: true

namespace :email_templates do # rubocop:disable Metrics/BlockLength
  desc 'Creates email templates for sending emails'

  task seed: :environment do # rubocop:disable Metrics/BlockLength
    email_templates = []
    email_templates << EmailTemplate.new(
      title:   'UserMailer#reset_password_instructions',
      body:    File.read('db/seed/email_templates/reset_password_instructions.md'),
      subject: 'Reset password instructions'
    )

    email_templates << EmailTemplate.new(
      title:   'UserMailer#confirmation_instructions',
      body:    File.read('db/seed/email_templates/confirmation_instructions.md'),
      subject: 'Confirmation instructions'
    )

    email_templates << EmailTemplate.new(
      title:   'VisitRequestMailer#confirmation',
      body:    File.read('db/seed/email_templates/confirmation.md'),
      subject: 'Event registration confirmation'
    )

    email_templates << EmailTemplate.new(
      title:   'VisitRequestMailer#approved',
      body:    File.read('db/seed/email_templates/approved.md'),
      subject: 'Event registration approved'
    )

    email_templates << EmailTemplate.new(
      title:   'VisitRequestMailer#needs_confirmation',
      body:    File.read('db/seed/email_templates/needs_confirmation.md'),
      subject: 'Event registration needs confirmation'
    )

    email_templates.each(&:save!)
  end
end
