class VisitRequestMailerPreview < ActionMailer::Preview
  def unverified_attendee
    @visit_request = VisitRequest.last
    VisitRequestMailer.unverified_attendee(@visit_request.id)
  end

  def confirmation
    @visit_request = VisitRequest.last
    VisitRequestMailer.confirmation(@visit_request)
  end

  def approved
    @visit_request = VisitRequest.last
    VisitRequestMailer.approved(@visit_request)
  end
end
