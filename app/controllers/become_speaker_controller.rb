class BecomeSpeakerController < ApplicationController
  def create
    NotifyMailer.become_speaker(name: params[:name], email: params[:email], text: params[:text]).deliver_later
    flash[:notice] = I18n.t('send_mail.sended')

    redirect_to members_path
  end
end
