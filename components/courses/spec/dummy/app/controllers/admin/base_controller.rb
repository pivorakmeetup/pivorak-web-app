# Mock of original controller
module Admin
  class BaseController < ApplicationController
    def self.add_breadcrumb(*)
    end

    def edit
      render_form
    end

    def current_user
      User.find_or_create_by(email: 'test@test.com', first_name: 'Test', last_name: 'User')
    end

    # def current_season
    #   ::Courses::Season.find_or_create_by(title: 'Test Season')
    # end

    private

    def render_form
      render :form
    end

    def semantic_breadcrumb(*)
    end

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
        flash_success and default_redirect
      else
        flash_error and render_form
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
      suffix   = params[:action] == 'destroy' ? 'ed' : 'd'
      action   = "#{params[:action]}#{suffix}"

      flash[type] = t(key || type, scope: :notifications, resource: resource, action: action)
    end
  end
end
