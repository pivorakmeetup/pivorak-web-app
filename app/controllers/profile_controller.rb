class ProfileController < ApplicationController
  before_action :authenticate_user!

  helper_method :profile

  def update
    if User::Update.call current_user, params[:user]
      flash[:notice] = t('notifications.success')
      redirect_to members_path(current_user)
    else
      flash[:error] = t('notifications.failure')
      render :edit
    end
  end

  private

  def profile
    @prifile ||= User.find(params[:id])
  end
end
