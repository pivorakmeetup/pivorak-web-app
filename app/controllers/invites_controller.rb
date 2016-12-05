class InvitesController < ApplicationController
  def new
  end

  def create
    Invite::Create.new(email: params[:email]).call
    flash[:notice] = I18n.t('invites.success', email: params[:email])
  rescue Slack::Client::AlreadyInTeam
    flash[:error] = I18n.t('invites.already_in_team')
  ensure
    redirect_to new_invites_path
  end
end
