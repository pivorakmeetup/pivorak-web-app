module Admin
  module EventsHelper
    BG_STATUS_CLASS = {
      Event::PLANNED      => 'olive',
      Event::REGISTRATION => 'green',
      Event::CONFIRMATION => 'teal',
      Event::LIVE         => 'red',
      Event::PASSED       => 'grey'
    }

    def admin_visit_requests_link(event, options = { class: 'item' })
      return unless event.persisted?

      link_to icon(:users, t('visit_requests.plural')),
        admin_event_visit_requests_path(event), options
    end

    def event_status_label(event)
      content_tag :span, event.status,
        class: ['ui label', BG_STATUS_CLASS[event.status.to_sym]]
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
        method: :post, class: 'ui button red',
        data: { confirm: t('phrases.confirm') }
    end
  end
end
