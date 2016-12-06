class ProfileController < ApplicationController
  before_action :authenticate_user!

  def edit
    render :edit, locals: { user: current_user }
  end

  def update
    if User::Update.new(params[:user].merge(user: current_user)).call
      flash[:notice] = t('shared.notifications.success')
    else
      flash[:error] = t('shared.notifications.failure')
    end
    render :edit, locals: { user: current_user }
  end
end
