module Admin
  class BaseController < ApplicationController
    layout 'admin'

    before_action :authenticate_user!
    after_action :prepare_unobtrusive_flash

    def flash_success(resource_name)
      flash[:success] = t("#{resource_name.to_s}.notifications.#{params[:action]}.success")
    end

    def flash_error(resource_name)
      flash[:error] = t("#{resource_name.to_s}.notifications.#{params[:action]}.error")
    end

  end
end
