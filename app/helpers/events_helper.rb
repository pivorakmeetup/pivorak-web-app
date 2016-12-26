module EventsHelper
  def attend_event_link(event)
    link_to t('visit_requests.attend'), attend_event_visit_requests_path(event), method: :put
  end

  def cancel_event_attendace_link(event, visit_request)
    link_to t('visit_requests.cancel_attendace'), event_visit_request_cancel_path(event, visit_request), method: :put
  end
end
