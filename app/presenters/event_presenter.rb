# frozen_string_literal: true

class EventPresenter < BasePresenter
  presents :event

  FOUR_SPEAKERS_CSS_CLASS = 'pk-main-speakers--four-speakers'
  EMPTY_CSS_CLASS = ''
  EXTENDED_EVENT_TALKS_COUNT = 4
  QR_CODE_IMAGE_SIZE = 600

  PARTIALS_COLLECTION = [
    EVENTS_CONFIRMATION_PARTIAL = 'events/confirmation',
    EVENTS_QR_CODE_PARTIAL      = 'events/qr_code',
    EVENTS_ATTENDANCE_PARTIAL   = 'events/attendance',
    EVENTS_UNAUTHORIZED_PARTIAL = 'events/unauthorized'
  ].freeze

  delegate :day, :month, :day_of_the_month, :hour, to: :date_presenter

  def speakers_css_class
    extended_event? ? FOUR_SPEAKERS_CSS_CLASS : EMPTY_CSS_CLASS
  end

  def show_talks?
    talks.any?
  end

  def action_button
    return confirmation_partial if confirmation_allowed?
    return authorized_variant if current_user

    { partial: EVENTS_UNAUTHORIZED_PARTIAL }
  end

  def talks_with_speaker
    @talks_with_speaker ||= Talk::WithSpeaker.call(event.id)
  end

  private

  def confirmation_allowed?
    confirmation? && !visit_request&.waiting_list?
  end

  def confirmation_partial
    { partial: EVENTS_CONFIRMATION_PARTIAL, locals: { visit_request: visit_request } }
  end

  def authorized_variant
    return  { partial: EVENTS_QR_CODE_PARTIAL, locals: { qr_code: qr_code_image } } if alowed_to_come?

    { partial: EVENTS_ATTENDANCE_PARTIAL, locals: { visit_request: visit_request, event: self } }
  end

  def alowed_to_come?
    live? && visit_request.approved? && !visit_request.visited
  end

  def qr_code_image
    @qr_code_image ||=
      VisitRequest::QrCode::Generate.call(visit_request).as_png(size: QR_CODE_IMAGE_SIZE).to_data_url
  end

  def extended_event?
    talks.count == EXTENDED_EVENT_TALKS_COUNT
  end

  def date_presenter
    @date_presenter ||= DatePresenter.new(started_at, h)
  end

  def visit_request
    return unless current_user

    @visit_request ||=
      VisitRequest.find_by(
        user_id:  current_user.id,
        event_id: id
      )
  end
end