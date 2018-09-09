module Admin
  class BaseController < ApplicationController
    layout 'admin'

    before_action :authenticate_user!
    before_action :authenticate_admin!

    def edit
      render_form
    end

    private

    def authenticate_admin!
      return if current_user&.admin?

      flash_error and redirect_to(root_path)
    end

    def only_supervisor!
      return if current_user&.admin? && current_user&.supervisor?

      flash_error and redirect_to(admin_path)
    end

    def search_against(model)
      Search::Resource.call params.merge(model: model)
    end

    def self.add_breadcrumb(i18n_label, path = nil)
      semantic_breadcrumb I18n.t(i18n_label), path
    end

    add_breadcrumb 'admin.admin', :admin_path # It must be bellow declaration

    def add_breadcrumb(resource, label: :title, path: nil)
      if resource.instance_of?(String)
        semantic_breadcrumb I18n.t(resource), path
      else
        semantic_breadcrumb resource.send(label), path
      end
    end

    def add_new_breadcump
      add_breadcrumb 'words.new'
    end

    def add_edit_breadcump
      add_breadcrumb 'words.edit'
    end

    def render_form
      render :form
    end

    def react_to(action)
      if action
        flash_success and default_redirect
      else
        flash_error and render_form
      end
    end

    def add_flash(type, key = nil)
      resource = params[:controller].split('/').last.singularize.capitalize
      suffix   = params[:action] == 'destroy' ? 'ed' : 'd'
      action   = "#{params[:action]}#{suffix}"

      flash[type] = t(key || type, scope: :notifications, resource: resource, action: action)
    end
  end
end
