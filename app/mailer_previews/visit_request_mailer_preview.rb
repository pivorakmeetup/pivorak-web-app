class VisitRequestMailerPreview
  def approved
    VisitRequestMailer.approved visit_request
  end

  def confirmation
    mail = VisitRequestMailer.confirmation visit_request
    Premailer::Rails::Hook.perform(mail)
  end

  def confirmation_reminder
    mail = VisitRequestMailer.confirmation_reminder visit_request
    Premailer::Rails::Hook.perform(mail)
  end

  def needs_confirmation
    VisitRequestMailer.needs_confirmation visit_request
  end

  def notify_admin_about_canceled_attendee
    VisitRequestMailer.notify_admin_about_canceled_attendee visit_request
  end

  def attendance_confirmed
    VisitRequestMailer.attendance_confirmed visit_request
  end

  private

  def visit_request
    VisitRequest.last
  end
end
