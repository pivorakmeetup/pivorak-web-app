# frozen_string_literal: true

# Mock of original controller
module Admin
  class BaseController < ApplicationController
    helper_method :current_user, :line_chart

    def self.add_breadcrumb(*); end

    def line_chart(*); end

    def edit
      render_form
    end

    def current_user
      User.find_or_create_by(email: 'test@test.com', first_name: 'Test', last_name: 'User')
    end

    private

    def render_form
      render :form
    end

    def semantic_breadcrumb(*); end

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

    def react_to(action)
      if action
        flash_success && default_redirect
      else
        flash_error && render_form
      end
    end

    def flash_success(key = nil)
      add_flash(:success, key)
    end

    def flash_error(key = nil)
      add_flash(:error, key)
    end

    def add_flash(type, key = nil)
      resource = params[:controller].split('/').last.singularize.capitalize
      suffix = params[:action] == 'destroy' ? 'ed' : 'd'
      action = "#{params[:action]}#{suffix}"

      flash[type] = t(key || type, scope: :notifications, resource: resource, action: action)
    end

    def current_user
      @current_user ||= User.where(id: 1).first_or_create(email: 'test@user.com', first_name: 'Test', last_name: 'User')
    end
  end
end
