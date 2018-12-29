module Admin
  module VisitRequestsHelper

    STATUS_CLASS = {
        ::VisitRequest::PENDING   => 'grey',
        ::VisitRequest::APPROVED  => 'success',
        ::VisitRequest::CANCELED  => 'red',
        ::VisitRequest::CONFIRMED => 'violet',
        ::VisitRequest::REFUSED   => 'black'
    }

    def visit_request_status_label(status)
      content_tag :div, status,
        class: ['ui label', STATUS_CLASS[status.to_sym]]
    end

    def admin_approve_visit_request_link(visit_request)
      return if visit_request.approved?

      link_to t('visit_requests.approve'),
        admin_event_visit_request_approve_path(visit_request.event, visit_request),
        method: :put, class: 'ui button green',
        data: { confirm: t('phrases.confirm') },
        remote: true
    end

    def admin_cancel_visit_request_link(visit_request)
      return if visit_request.canceled?

      link_to t('visit_requests.cancel'),
        admin_event_visit_request_cancel_path(visit_request.event, visit_request),
        method: :put, class: 'ui button red',
        data: { confirm: t('phrases.confirm') },
        remote: true
    end

    def visit_request_list_link(visit_request)
      label      = visit_request.waiting_list? ? 'waiting_list' : 'main_list'
      btn_class  = visit_request.waiting_list? ? 'grey' : 'green'
      i18n_label = t(label, scope: 'visit_requests')

      link_to i18n_label,
        admin_event_visit_request_toggle_list_path(visit_request.event, visit_request),
        method: :put, class: ['ui', 'button', btn_class],
        data: { confirm: t('phrases.confirm') },
        remote: true
    end

    def visit_request_check_in_link(visit_request)
      return t('visit_request.check_in.already_checked_in') if visit_request.visited?

      link_to t('visit_request.check_in.plural'),
      admin_visit_request_check_in_path(visit_request.token, redirect_back: true),
        class: ['ui button', 'green']
    end
  end
end
