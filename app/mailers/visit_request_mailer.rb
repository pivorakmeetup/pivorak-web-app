class VisitRequestMailer < ApplicationMailer
  def approved(visit_request)
    @visit_request = visit_request
    @event         = @visit_request.event
    @user          = @visit_request.user

    mail(subject: email_template.subject, to: @user.email) do |format|
      format.html { email_template.render(event: @event, user: @user, visit_request: @visit_request) }
    end
  end

  def confirmation(visit_request)
    @visit_request = visit_request
    @event         = @visit_request.event
    @user          = @visit_request.user

    attachments['event.ics'] = Event::ExportToIcal.call(@event)
    mail(subject: email_template.subject, to: @user.email) do |format|
      format.html { email_template.render(visit_request: @visit_request, user: @user, event: @event) }
    end
  end

  def needs_confirmation(visit_request)
    @visit_request = visit_request
    @event         = @visit_request.event
    @user          = @visit_request.user

    mail(subject: email_template.subject, to: @user.email) do |format|
      format.html { email_template.render(event: @event, user: @user, visit_request: @visit_request) }
    end
  end

  def notify_admin_about_unverified_attendee(visit_request)
    @user = visit_request.user
    @event = visit_request.event

    mail(to: PIVORAK_EMAIL, from: NO_REPLY_EMAIL, subject: email_template.subject) do |format|
      format.html { email_template.render(user: @user, event: @event) }
    end
  end

  def unverified_attendee(visit_request)
    notify_admin_about_unverified_attendee(visit_request)
  end
end
