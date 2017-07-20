class SeedNotifyAdminAboutCanceledAttendee < ActiveRecord::Migration[5.0]
  def up
    EmailTemplate.create!(
      title: 'VisitRequestMailer#notify_admin_about_canceled_attendee',
      subject: 'Attendee canceled his request',
      note: 'Will be sent when attendee cancels his request',
      body: File.read('db/seed/email_templates/notify_admin_about_canceled_attendee.md'),
    )
  end

  def down
    EmailTemplate.delete_all(title: 'VisitRequestMailer#notify_admin_about_canceled_attendee')
  end
end
