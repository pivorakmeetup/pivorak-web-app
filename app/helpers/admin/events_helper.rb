module Admin
  module EventsHelper
    BG_STATUS_CLASS = {
      Event::PLANNED => 'bg-primary',
      Event::REGISTRATION => 'bg-success',
      Event::CONFIRMATION => 'bg-warning',
      Event::LIVE => 'bg-danger',
      Event::PASSED => 'bg-inverse'
    }

    def admin_visit_requests_link(event)
      link_to t('visit_requests.plural'),
        admin_event_visit_requests_path(event),
        class: 'btn btn-primary'
    end

    def event_status_label(event)
      content_tag :span, event.status,
        class: ['label', BG_STATUS_CLASS[event.status.to_sym]]
    end

    def event_limitation_data(event)
      total    = event.limit_total
      verified = event.visit_requests.approved.count
      pending  = event.visit_requests.pending.count

      "#{total} / #{verified} / #{pending}"
    end

    def send_confirmation_emails_link(event)
      return unless event.confirmation?

      link_to t('events.send_confirmations'),
        send_confirmations_admin_event_visit_requests_path(event),
        method: :post, class: 'btn btn-danger float-xs-right'
    end
  end
end
