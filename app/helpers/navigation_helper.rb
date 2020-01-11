# frozen_string_literal: true

module NavigationHelper
  def events_link
    link_to t('events.plural'), events_path
  end

  def talks_link(title: I18n.t('talks.plural'))
    link_to title, talks_path
  end

  def support_us_link(**options)
    link_to t('support_us'), donate_path, data: { turbolinks: false }, **options
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
    link_to t('members.profile'), edit_profile_path
  end

  def admin_link
    link_to t('admin.admin'), admin_path
  end

  def agenda_link
    return unless Event.upcoming

    link_to t('words.agenda'), agenda_path
  end

  def about_link
    link_to t('words.about'), '/about'
  end

  def ruby_course_link
    link_to 'Become a student of Ruby Summer Course', '/ruby-course'
  end
end
