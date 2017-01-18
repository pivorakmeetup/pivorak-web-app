module EventsHelper
  def attend_event_link(event, visit_request)
    return unless current_user

    return if visit_request&.pending?
    return if visit_request&.approved?

    link_to t('visit_requests.attend'), event_visit_requests_path(event), method: :post
  end

  def cancel_event_attendace_link(visit_request)
    return unless visit_request

    return if visit_request&.canceled?

    link_to t('visit_requests.cancel_attendace'),
      event_visit_request_path(visit_request.event, visit_request),
      method: :delete, data: { confirm: t('phrases.confirm') }
  end


  def waiting_list_message
    return if Event::SlotsPolicy.new(event).has_free_slot_for?(current_user)
    return if event.visitors.include?(current_user)

    t('visit_requests.messages.waiting_list')
  end

  def visit_request_confirm_message(visit_request)
    if visit_request.confirmed?
      t('visit_requests.messages.see_you')
    elsif visit_request.refused?
      t('visit_requests.messages.so_pity')
    else
    t('visit_requests.messages.please_confirm')
    end
  end

  def visit_request_confirm_link(visit_request)
    return if visit_request.final_decision?

    link_to t('visit_requests.confirm'),
      visit_request_confirm_path(visit_request, :yes),
      data: { confirm: t('phrases.confirm') }
  end

  def visit_request_refuse_link(visit_request)
    return if visit_request.final_decision?

    link_to t('visit_requests.refuse'),
      visit_request_confirm_path(visit_request, :no),
      data: { confirm: t('phrases.confirm') }
  end

  def visit_request_status_message(visit_request)
    return unless visit_request

    t(visit_request.status, scope: 'visit_requests.messages')
  end

  private

  def visit_request_confirm_path(visit_request, answer)
    event_visit_request_path(visit_request.event, visit_request,
      answer: answer, token: visit_request.token)
  end
end
