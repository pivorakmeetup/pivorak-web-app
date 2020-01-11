# frozen_string_literal: true

class VisitRequestMailer < ApplicationMailer
  def approved(visit_request)
    @visit_request = visit_request
    @event         = @visit_request.event
    @user          = @visit_request.user

    mail(subject: email_template.subject, to: @user.email) do |format|
      format.html { email_template.render(event: @event, user: @user, visit_request: @visit_request) }
    end
  end

  def confirmation(visit_request) # rubocop:disable Metrics/AbcSize
    @visit_request     = visit_request
    @event             = @visit_request.event
    @venue             = @event.venue
    @user              = @visit_request.user
    @confirm_visit_url = event_visit_request_url(
      @event, @visit_request, answer: :yes, token: @visit_request.token, host: host
    )
    @cancel_visit_url = event_visit_request_url(
      @event, @visit_request, answer: :no, token: @visit_request.token, host: host
    )
    @start_at_date = @event.started_at.strftime('%A, %d of %B')
    @start_at_time = @event.started_at.strftime('%H:%M')
    @agenda = MarkdownRenderer.call(@event.agenda)

    attachments['event.ics'] = Event::ExportToIcal.call(@event)
    mail(subject: "#pivorak details | #{@event.title}", to: @user.email)
  end

  def confirmation_reminder(visit_request)
    @visit_request     = visit_request
    @event             = @visit_request.event
    @user              = @visit_request.user
    @confirm_visit_url = event_visit_request_url(
      @event, @visit_request, answer: :yes, token: @visit_request.token, host: host
    )
    @cancel_visit_url = event_visit_request_url(
      @event, @visit_request, answer: :no, token: @visit_request.token, host: host
    )

    mail(subject: "#pivorak reminder | #{@event.title}", to: @user.email)
  end

  def needs_confirmation(visit_request)
    @visit_request = visit_request
    @event         = @visit_request.event
    @user          = @visit_request.user

    mail(subject: email_template.subject, to: @user.email) do |format|
      format.html { email_template.render(event: @event, user: @user, visit_request: @visit_request) }
    end
  end

  def notify_admin_about_canceled_attendee(visit_request)
    @user = visit_request.user
    @event = visit_request.event

    mail(to: PIVORAK_EMAIL, from: NO_REPLY_EMAIL, subject: email_template.subject) do |format|
      format.html { email_template.render(user: @user, event: @event) }
    end
  end

  def attendance_confirmed(visit_request)
    @visit_request = visit_request
    @event         = @visit_request.event
    @user          = @visit_request.user
    @venue         = @event.venue
    @qr_code       = VisitRequest::QrCode::Generate.call(visit_request)

    attachments["#{@event.slug}.pdf"] = VisitRequest::QrCode::Pdf.call(visit_request)

    mail(subject: '#pivorak confirmation | QR code is attached', to: @user.email)
  end

  private

  def host
    Rails.application.config.action_mailer[:default_url_options][:host]
  end
end
