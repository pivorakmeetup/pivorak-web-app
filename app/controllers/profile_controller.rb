class ProfileController < ApplicationController
  before_action :authenticate_user!

  helper_method :profile

  def update
    if User::Update.call current_user, params[:user]
      flash[:notice] = t('notifications.success')
      redirect_to root_path
    else
      flash[:error] = t('notifications.failure')
      render :edit
    end
  end
end
