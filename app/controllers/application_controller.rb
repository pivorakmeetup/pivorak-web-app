class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :admin?, :about_page

  delegate :admin?, to: :current_user, allow_nil: true

  before_action :coming_soon? # TODO VS -> Remove after 1.0 release

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

  # TODO VS -> Remove after 1.0 release
  def coming_soon?
    redirect_to(coming_soon_path) unless skip_coming_soon
  end

  def about_page
    @about_page ||= Page.find_by(url: 'about')
  end

  private

  # TODO VS -> Remove after 1.0 release
  def skip_coming_soon
    !Rails.env.production? ||
      admin?               ||
        devise_controller? ||
          action_name == 'coming_soon'
  end
end
