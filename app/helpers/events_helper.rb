module EventsHelper
  def attend_event_link(event, visit_request)
    return unless current_user_id

    return if visit_request&.pending?
    return if visit_request&.approved?

    return if !(Event::SlotsPolicy.new(event).has_free_slot_for?(current_user_id))
    return if event.visitor_ids.include?(current_user_id)

    link_to t('visit_requests.attend'), event_visit_requests_path(event), method: :post, class: "pk-btn pk-btn--biggest"
  end

  def cancel_event_attendace_link(visit_request)
    return unless visit_request

    return if visit_request&.canceled?

    link_to t('visit_requests.cancel_attendace'),
      event_visit_request_path(visit_request.event, visit_request),
      method: :delete, data: { confirm: t('phrases.confirm') }
  end

  def waiting_list_message
    return if Event::SlotsPolicy.new(event).has_free_slot_for?(current_user_id)
    return if event.visitor_ids.include?(current_user_id)

    render html: "#{t('visit_requests.messages.waiting_list')} #{link_to t('visit_requests.attend'), event_visit_requests_path(event), method: :post}".html_safe
  end

  def visit_request_confirm_message(visit_request)
    return unless visit_request && current_user_id

    if visit_request.confirmed?
      t('visit_requests.messages.see_you')
    elsif visit_request.refused?
      t('visit_requests.messages.so_pity')
    else
    t('visit_requests.messages.please_confirm')
    end
  end

  def visit_request_confirm_link(visit_request)
    return unless visit_request && current_user_id
    return if visit_request.final_decision?

    link_to t('visit_requests.confirm'),
      visit_request_confirm_path(visit_request, :yes),
      data: { confirm: t('phrases.confirm') }
  end

  def visit_request_refuse_link(visit_request)
    return unless visit_request && current_user_id
    return if visit_request.final_decision?

    link_to t('visit_requests.refuse'),
      visit_request_confirm_path(visit_request, :no),
      data: { confirm: t('phrases.confirm') }
  end

  def visit_request_status_message(visit_request)
    return unless visit_request

    render html: "#{t(visit_request.status, scope: 'visit_requests.messages')} <br/>".html_safe
  end

  def visit_request_please_text(visit_request)
    return if visit_request

    t('visit_requests.messages.registration_closed').html_safe
  end

  private

  def visit_request_confirm_path(visit_request, answer)
    event_visit_request_path(visit_request.event, visit_request,
      answer: answer, token: visit_request.token)
  end
end
