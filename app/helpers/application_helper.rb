# frozen_string_literal: true

module ApplicationHelper
  BECOME_SPEAKER_URL = 'https://goo.gl/YxtVro'

  def format_timestamp(timestamp, time: true, delimiter: '-')
    return unless timestamp

    formatted_date = timestamp.strftime('%Y %b %d')
    formatted_time = timestamp.strftime('%H:%M')

    return formatted_date unless time

    "#{formatted_date} #{delimiter} #{formatted_time}"
  end

  def markdownify(content)
    MarkdownRenderer.call(content)
  end

  def unauthorized_message(action_message)
    return if current_user

    t('phrases.unauthorized',
      action_message: action_message,
      login_url:      new_user_session_path,
      register_url:   new_user_registration_path).html_safe
  end

  def title(page_title)
    content_for(:title) { page_title }
  end

  def become_a_speaker_link(**options)
    link_to t('phrases.become_speaker'), BECOME_SPEAKER_URL, options.merge(target: '_blank')
  end

  def admin_area
    return unless admin?

    content_tag(:div, class: 'pk-admin-area') do
      yield
    end
  end
end
