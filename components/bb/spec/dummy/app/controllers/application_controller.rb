class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user

  def authenticate_user!
  end

  def flash_success
    true
  end

  def flash_error
    true
  end

  def current_user
  end
end
