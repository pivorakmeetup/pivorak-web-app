class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :admin?

  before_action :authorize_admin!,
    only:   %i[new edit create update destroy],
    unless: :devise_controller?

  def authorize_admin!
    return true if current_user&.admin?

    redirect_to root_path
  end

  def admin?
    current_user&.admin?
  end
end
