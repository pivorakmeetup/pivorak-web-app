module EventsHelper
  # Used at commented part on events/show.slim
  #
  # TODO: revisit progess bar to unblock production (copypasted comment)
  #
  # def get_place_left_counter(event)
  #   "#{event.limit_total} #{t('events.free_places')}"
  # end

  # def get_event_fullness_percent(event)
  #   return 0 if event.limit_total.zero?
  #   (event.visit_requests.approved.count.to_f / event.limit_total) * 100
  # end
end
