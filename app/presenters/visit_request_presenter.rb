# frozen_string_literal: true

class VisitRequestPresenter < BasePresenter
  presents :visit_request

  YES = :yes
  NO  = :no
  ATTEND_LINK_CLASS = 'pk-btn pk-btn--biggest'

  def attend_event_link(event)
    return unless current_user
    return if cannot_attend(event)

    link_to t('visit_requests.attend'),
      h.event_visit_requests_path(event),
      method: :post,
      class: ATTEND_LINK_CLASS
  end

  def cancel_event_attendace_link
    return unless visit_request
    return if canceled?

    link_to t('visit_requests.cancel_attendace'),
      h.event_visit_request_path(event, visit_request, token: token),
      method: :delete, data: confirm_data
  end

  def visit_request_confirm_link
    return unless user_and_request?
    return if final_decision?

    translation = t('visit_requests.confirm')

    visit_request_link(translation, YES)
  end

  def visit_request_refuse_link
    return unless user_and_request?
    return if refused?

    translation = t('visit_requests.refuse')

    visit_request_link(translation, NO)
  end

  def visit_request_status_message
    return unless visit_request

    render html: "#{t(visit_request.status, scope: 'visit_requests.messages')} <br/>".html_safe
  end

  def visit_request_please_text
    return if visit_request

    t('visit_requests.messages.registration_closed').html_safe
  end

  def visit_request_confirm_message
    return unless user_and_request?

    return t('visit_requests.messages.see_you') if confirmed?
    return t('visit_requests.messages.so_pity') if refused?

    t('visit_requests.messages.please_confirm')
  end

  def waiting_list_message(event)
    return if can_host_current_user?(event) || !pending?

    message = t('visit_requests.messages.waiting_list')
    link = link_to t('visit_requests.attend'), h.event_visit_requests_path(event), method: :post

    render html: "#{message} #{link}".html_safe
  end

  private

  def visit_request_link(translation, answer)
    link_to translation,
      visit_request_confirm_path(visit_request, answer),
      data: confirm_data
  end

  def confirm_data
    { confirm: t('phrases.confirm') }
  end

  def cannot_attend(event)
    visit_request&.pending? ||
      visit_request&.approved? ||
      !can_host_current_user?(event)
  end

  def user_and_request?
    visit_request && current_user
  end

  def visit_request_confirm_path(visit_request, answer)
    h.event_visit_request_path(event, visit_request,
      answer: answer, token: token)
  end

  def can_host_current_user?(event)
    Event::SlotsPolicy.new(event).has_free_slot_for?(current_user) ||
      !event.visitors.include?(current_user)
  end
end