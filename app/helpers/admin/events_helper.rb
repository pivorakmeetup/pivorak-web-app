module Admin
  module EventsHelper
    def admin_new_event_link
      link_to t('phrases.new_resource', resource: t('events.singular')),
        new_admin_event_path,
        class: 'btn btn-success'
    end

    def admin_event_link(event)
      link_to event.title, event_path(event), target: '_blank'
    end

    def admin_edit_event_link(event)
      link_to t('words.edit'), edit_admin_event_path(event)
    end

    def admin_visit_requests_link(event)
      link_to t('visit_requests.plural'), admin_event_visit_requests_path(event)
    end

    def admin_approve_visit_request_link(event, visit_request)
      link_to t('visit_requests.approve'), admin_event_visit_request_approve_path(event, visit_request), method: :patch
    end

    def admin_cancel_visit_request_link(event, visit_request)
      link_to t('visit_requests.cancel'), admin_event_visit_request_cancel_path(event, visit_request), method: :patch
    end

  end
end
