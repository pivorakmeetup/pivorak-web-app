class VisitRequestMailerPreview
  def confirmation
    VisitRequestMailer.confirmation visit_request
  end


  def unverified_attendee
    VisitRequestMailer.unverified_attendee visit_request_id
  end


  def approved
    VisitRequestMailer.approved visit_request
  end

  private

  def visit_request
    VisitRequest.last
  end

  def visit_request_id
    visit_request.id
  end
end
