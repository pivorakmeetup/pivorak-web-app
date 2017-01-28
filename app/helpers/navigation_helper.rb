module NavigationHelper
  def events_link
    link_to t('events.plural'), events_path
  end

  def talks_link(title: I18n.t('talks.plural'))
    link_to title, talks_path
  end

  # Skip until 1.1 version
  # def goals_link
  #   link_to t('goals.plural'), goals_path
  # end

  def donate_link
    link_to t('donations.donate'), donate_path
  end

  def chat_link
    link_to t('chat.singular'), chat_path
  end

  def members_link
    link_to t('members.plural'), members_path
  end

  def speakers_link
    link_to t('speakers.plural'), speakers_path
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

  def profile_link
    link_to t('members.profile'), profile_path
  end

  def admin_link
    link_to t('admin.admin'), admin_path
  end
end
