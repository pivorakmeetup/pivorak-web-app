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
end
