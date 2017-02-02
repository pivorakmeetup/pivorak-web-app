class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :admin?

  delegate :admin?, to: :current_user, allow_nil: true

  before_action :coming_soon?

  def not_found
    render file: "#{Rails.root}/public/404", layout: false, status: :not_found
  end

  def coming_soon?
    redirect_to(coming_soon_path) unless skip_coming_soon
  end

  private

  def skip_coming_soon
    !Rails.env.production? ||
      current_user&.admin? ||
        devise_controller? ||
          action_name == 'coming_soon'
  end
end
