# frozen_string_literal: true

class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  protect_from_forgery with: :exception, prepend: true

  helper_method :admin?
  helper_method :student

  delegate :admin?, to: :current_user, allow_nil: true
  before_action :check_for_maintenance!

  # Workaround to allows PUMA work faster for better_errors
  before_action :better_errors_hack, if: -> { Rails.env.development? }
  def better_errors_hack
    request.env['puma.config'].options.user_options.delete :app
  end

  def self.disabled_feature_until(release)
    until_version = Versionomy.parse(release.to_s)

    before_action do
      if Rails.env.production? && current_version < until_version && !admin?
        flash[:warninng] = 'Sorry, this feature is not yet available.'
        redirect_to(root_path)
      end
    end
  end

  def current_version
    @current_version ||= Versionomy.parse(PivorakWebApp::Application.config.version)
  end

  def not_found
    render file: 'public/404.html', status: :not_found, layout: false
  end

  def flash_success(key = nil)
    add_flash(:success, key)
  end

  def flash_error(key = nil)
    add_flash(:error, key)
  end

  def add_flash(type, key = nil)
    resource = params[:controller].tr('/', '.')
    action   = params[:action]

    flash[type] = t(key || type, scope: [:flash, resource, action])
  end


  def student
    return unless current_user

    @student ||= ::Courses::Student.without_rejected.find_by(user_id: current_user.id)
  end

  private

  def check_for_maintenance!
    redirect_to maintenance_path if maintenance_enabled?
  end

  def maintenance_enabled?
    enabled = Ez::Settings[:app, :maintenance, :enabled]
    ActiveModel::Type::Boolean.new.cast(enabled.to_s)
  end
end
