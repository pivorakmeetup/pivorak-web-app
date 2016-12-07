class ProfileController < ApplicationController
  before_action :authenticate_user!

  def show
    render_profile
  end

  def edit
    render_profile
  end

  def update
    if User::Update.new(params[:user].merge(user: current_user)).call
      flash[:notice] = t('shared.notifications.success')
    else
      flash[:error] = t('shared.notifications.failure')
    end
    render_profile
  end

  private

  def render_profile
    render :edit
  end
end
