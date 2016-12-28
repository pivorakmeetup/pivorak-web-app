module ApplicationHelper
  def format_timestamp(timestamp, time: true, delimiter: '-')
    formatted_date = timestamp.strftime('%Y %b %d')
    formatted_time = timestamp.strftime('%H:%M')

    return formatted_date if !time

    "#{formatted_date} #{delimiter} #{formatted_time}"
  end
end
