class VisitRequestMailer < ApplicationMailer
  def unverified_attendee(visit_request_id)
    visit_request = VisitRequest.find(visit_request_id)
    @user = visit_request.user
    @event = visit_request.event

    mail(from: "#{@user.full_name} <#{@user.email}>",
         subject: I18n.t('mailers.visit_request_mailer.unverified_attendee.subject'),
         to: PIVORAK_EMAIL)
  end
end
