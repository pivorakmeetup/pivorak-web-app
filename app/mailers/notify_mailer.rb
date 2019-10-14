# frozen_string_literal: true

class NotifyMailer < ApplicationMailer
  def become_speaker(params)
    name = params[:name]
    email = params[:email]
    text = params[:text]

    mail(from:    "#{name} <#{email}>",
         subject: I18n.t('mailers.notify_mailer.become_speaker.subject'),
         to:      PIVORAK_EMAIL) do |format|
      format.html { text }
    end
  end
end
