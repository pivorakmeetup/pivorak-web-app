class VisitRequestMailerPreview
  def approved
    VisitRequestMailer.approved visit_request
  end

  def confirmation
    VisitRequestMailer.confirmation visit_request
  end

  def needs_confirmation
    VisitRequestMailer.needs_confirmation visit_request
  end

  def notify_admin_about_unverified_attendee
    VisitRequestMailer.notify_admin_about_unverified_attendee visit_request
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
