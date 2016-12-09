class ChatController < ApplicationController
  def create
    if Chat::Invite.call(params[:email])
      flash[:notice] = I18n.t('chat.success', email: params[:email])
    else
      flash[:error] = I18n.t('chat.email_required')
    end

  rescue Chat::Client::ChatError => error
    flash[:error] = I18n.t(error, scope: 'chat.errors')

  ensure
    redirect_to chat_path
  end
end
