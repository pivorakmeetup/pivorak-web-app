module NavigationHelper
  def events_link
    link_to t('events.plural'), events_path
  end

  def talks_link
    link_to t('talks.plural'), talks_path
  end

  def logout_link
    link_to t('devise.base.logout'), destroy_user_session_path, method: :delete
  end

  def login_link
    link_to t('devise.base.login'), new_user_session_path
  end

  def register_link
    link_to t('devise.base.register'), new_user_registration_path
  end
end
