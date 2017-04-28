class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception, prepend: true

  helper_method :admin?, :about_page, :contacts_page, :course_page

  delegate :admin?, to: :current_user, allow_nil: true

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
    render file: "#{Rails.root}/public/404", layout: false, status: :not_found
  end

  def about_page
    @about_page ||= Page.find_by(url: 'about')
  end

  def contacts_page
    @contacts_page ||= Page.find_by(url: 'contacts')
  end

  def course_page
    @course_page ||= Page.find_by(url: 'ruby-course')
  end

  def flash_success(key = nil)
    add_flash(:success, key)
  end

  def flash_error(key = nil)
    add_flash(:error, key)
  end

  def add_flash(type, key = nil)
    resource = params[:controller].gsub('/', '.')
    action   = params[:action]

    flash[type] = t(key || type, scope: [:flash, resource, action])
  end
end
