# frozen_string_literal: true

class ProfileController < ApplicationController
  before_action :authenticate_user!

  helper_method :profile

  def update
    if User::Update.call current_user, params[:user]
      flash[:notice] = t('members.success')
      redirect_to root_path
    else
      flash[:alert] = t('members.failure')
      render :edit
    end
  end
end
