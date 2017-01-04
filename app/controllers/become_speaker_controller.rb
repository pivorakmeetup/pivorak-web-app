class BecomeSpeakerController < ApplicationController
  def create
    NotifyMailer.become_speaker(email_params).deliver_later
    flash[:notice] = I18n.t('send_mail.sended')

    redirect_to members_path
  end

  private

  def email_params
    params.permit(:name, :email, :text)
  end
end
