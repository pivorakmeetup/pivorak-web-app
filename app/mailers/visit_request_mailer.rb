class VisitRequestMailer < ApplicationMailer
  def unverified_attendee(visit_request_id)
    visit_request = VisitRequest.find(visit_request_id)
    @user = visit_request.user
    @event = visit_request.event

    mail to:      PIVORAK_EMAIL,
         from:    NO_REPLY_EMAIL,
         subject: I18n.t('mailers.visit_request_mailer.unverified_attendee.subject')

  end

  def confirmation(visit_request)
    @visit_request = visit_request
    @event         = @visit_request.event
    @user          = @visit_request.user

    mail to:      @user.email,
         subject: "#{@event.title} Final Confirmation"
  end

  def approved(visit_request)
    @visit_request = visit_request
    @event         = @visit_request.event
    @user          = @visit_request.user

    mail to:      @user.email,
         subject: "#{@event.title} visit approved. See you!"
  end
end
