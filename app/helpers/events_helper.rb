module EventsHelper
  def attend_event_link(event)
    return unless current_user

    return if visit_request&.pending?
    return if visit_request&.approved?

    link_to t('visit_requests.attend'), event_visit_requests_path(event), method: :post
  end

  def cancel_event_attendace_link(event)
    return unless visit_request

    return if visit_request&.canceled?

    link_to t('visit_requests.cancel_attendace'),
      event_visit_request_path(event, visit_request),
      method: :delete, data: { confirm: t('phrases.confirm') }
  end

  def visit_request_status_message
    return unless visit_request

    t(visit_request.status, scope: 'visit_requests.messages')
  end

  def waiting_list_message
    return unless current_user

    return if event.has_free_slot_for?(current_user)
    return if event.visitors.include?(current_user)

    t('visit_requests.messages.waiting_list')
  end
end
