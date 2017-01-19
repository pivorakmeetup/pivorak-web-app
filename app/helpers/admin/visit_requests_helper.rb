module Admin
  module VisitRequestsHelper

    STATUS_CLASS = {
        ::VisitRequest::PENDING => 'bg-info',
        ::VisitRequest::APPROVED => 'bg-primary',
        ::VisitRequest::CANCELED => 'bg-danger',
        ::VisitRequest::CONFIRMED => 'bg-success',
        ::VisitRequest::REFUSED => 'bg-inverse'
    }

    def visit_request_status_label(status)
      content_tag :div, status,
        class: ['label', STATUS_CLASS[status.to_sym]]
    end

    def admin_approve_visit_request_link(visit_request)
      return if visit_request.approved?

      link_to t('visit_requests.approve'),
        admin_event_visit_request_approve_path(visit_request.event, visit_request),
        method: :put, class: 'btn btn-success',
        data: { confirm: t('phrases.confirm') }
    end

    def admin_cancel_visit_request_link(visit_request)
      return if visit_request.canceled?

      link_to t('visit_requests.cancel'),
        admin_event_visit_request_cancel_path(visit_request.event, visit_request),
        method: :put, class: 'btn btn-danger',
        data: { confirm: t('phrases.confirm') }
    end

    def visit_request_list_link(visit_request)
      label = visit_request.waiting_list? ? 'waiting_list' : 'main_list'
      btn_class = visit_request.waiting_list? ? 'btn-secondary' : 'btn-primary'
      i18n_label = t(label, scope: 'visit_requests')

      link_to i18n_label,
        admin_event_visit_request_toggle_list_path(visit_request.event, visit_request),
        method: :put, class: ['btn', btn_class],
        data: { confirm: t('phrases.confirm') }
    end

    def visit_request_visited_link(visit_request)
      label = visit_request.visited? ? 'waiting' : 'hello'
      btn_class = visit_request.visited? ? 'btn-secondary' : 'btn-success'
      i18n_label = t(label, scope: 'visit_requests')

      link_to i18n_label,
        admin_event_visit_request_toggle_visit_path(visit_request.event, visit_request),
        method: :put, class: ['btn', btn_class],
        data: { confirm: t('phrases.confirm') }
    end
  end
end
