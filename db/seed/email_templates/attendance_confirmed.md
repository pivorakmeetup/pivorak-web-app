Hi, #{@user.full_name}!

Thanks for confirming your attendance.
See you at the event at #{I18n.localize @event.started_at, format: :date_month_year_and_date_time} in #{@venue.name}.
Show the QR code from the attachments at the entrance.
