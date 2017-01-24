class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :admin?

  delegate :admin?, to: :current_user, allow_nil: true

  def not_found
    render file: "#{Rails.root}/public/404", layout: false, status: :not_found
  end
end
