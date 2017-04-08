module ApplicationHelper
  def format_timestamp(timestamp, time: true, delimiter: '-')
    return unless timestamp

    formatted_date = timestamp.strftime('%Y %b %d')
    formatted_time = timestamp.strftime('%H:%M')

    return formatted_date if !time

    "#{formatted_date} #{delimiter} #{formatted_time}"
  end

  def unauthorized_message(action_message)
    return if current_user_id

    t('phrases.unauthorized',
      action_message: action_message,
      login_url:      new_user_session_path,
      register_url:   new_user_registration_path
     ).html_safe
  end

  def title(page_title)
    content_for(:title) { page_title }
  end
end
