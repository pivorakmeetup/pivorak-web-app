class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :admin?

  def admin?
    current_user&.admin?
  end
end
