class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def authenticate_user!
  end

  def flash_success
    true
  end

  def flash_error
    true
  end

  def current_user
    User.find_or_create_by(email: 'test@test.com', first_name: 'Test', last_name: 'User')
  end
end
