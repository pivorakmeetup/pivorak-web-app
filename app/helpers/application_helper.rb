module ApplicationHelper
  def format_timestamp(timestamp)
    timestamp.strftime('%Y %b %d - %H:%M')
  end
end
