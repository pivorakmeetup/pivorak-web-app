class VisitRequestMailer < ApplicationMailer
  def unverified_attendee(visit_request_id)
    visit_request = VisitRequest.find(visit_request_id)
    @user = visit_request.user
    @event = visit_request.event

    mail(to: PIVORAK_EMAIL, from: NO_REPLY_EMAIL, subject: email_template.subject) do |format|
      format.html { email_template.render(user: @user, event: @event) }
    end
  end

  def confirmation(visit_request)
    @visit_request = visit_request
    @event         = @visit_request.event
    @user          = @visit_request.user

    mail(subject: email_template.subject, to: @user.email) do |format|
      format.html { email_template.render(visit_request: @visit_request, user: @user, event: @event) }
    end
  end

  def approved(visit_request)
    @visit_request = visit_request
    @event         = @visit_request.event
    @user          = @visit_request.user

    mail(subject: email_template.subject, to: @user.email) do |format|
      format.html { email_template.render(event: @event, user: @user, visit_request: @visit_request) }
    end
  end
end
