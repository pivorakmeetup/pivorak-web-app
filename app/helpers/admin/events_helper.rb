module Admin
  module EventsHelper
    def admin_visit_requests_link(event)
      link_to icon(:bell),
        admin_event_visit_requests_path(event)
    end

    def admin_approve_visit_request_link(event, visit_request)
      link_to t('visit_requests.approve'),
        admin_event_visit_request_approve_path(event, visit_request),
        method: :put
    end

    def admin_cancel_visit_request_link(event, visit_request)
      link_to t('visit_requests.cancel'),
        admin_event_visit_request_cancel_path(event, visit_request),
        method: :put
    end
  end
end
