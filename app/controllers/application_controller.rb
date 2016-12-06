class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :admin?

  delegate :admin?, to: :current_user, allow_nil: true
end
