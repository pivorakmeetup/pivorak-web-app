module Admin
  module EventsHelper
    def admin_visit_requests_link(event)
      link_to t('visit_requests.plural'),
        admin_event_visit_requests_path(event),
        class: 'btn btn-primary'
    end
  end
end
