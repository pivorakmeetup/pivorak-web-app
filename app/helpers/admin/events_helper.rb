# frozen_string_literal: true

module Admin
  module EventsHelper
    BG_STATUS_CLASS = {
      Event::PLANNED      => 'olive',
      Event::REGISTRATION => 'green',
      Event::CONFIRMATION => 'teal',
      Event::LIVE         => 'red',
      Event::PASSED       => 'grey'
    }.freeze

    def admin_visit_requests_link(event, options = { class: 'item' })
      return unless event.persisted?

      link_to icon(:users, t('visit_requests.plural')),
              admin_event_visit_requests_path(event), options
    end

    def admin_visitors_report_link(event)
      return unless event.confirmation?

      link_to icon(:download, t('events.visitors_report')),
              report_admin_event_visit_requests_path(event),
              class: 'item'
    end

    def default_limit_total
      return event.limit_total if Event.exists?(event.id)

      Ez::Settings[:app, :events, :default_limit]
    end

    def default_limit_verified
      return event.limit_verified if Event.exists?(event.id)

      Ez::Settings[:app, :events, :default_limit_verified]
    end

    def event_status_label(event)
      content_tag :span, event.status,
                  class: ['ui label', BG_STATUS_CLASS[event.status.to_sym]]
    end

    def event_visitors(event)
      requested = event.pending_visit_requests.length
      approved  = event.approved_visit_requests.length
      confirmed = event.confirmed_visit_requests.length
      visited   = event.used_visit_requests.length

      {
        t('events.index.visitors.requested') => (requested + approved + confirmed),
        t('events.index.visitors.approved')  => (approved + confirmed),
        t('events.index.visitors.confirmed') => confirmed,
        t('events.index.visitors.visited')   => visited
      }
    end

    def event_verified_user_data(event)
      verified = event.verified_visitors.length
      newbies  = event.newbie_visitors.length

      "#{verified} / #{newbies}"
    end

    def send_confirmation_emails_link(event)
      return unless event.confirmation?

      link_to t('events.send_confirmations'),
              send_confirmations_admin_event_visit_requests_path(event),
              method: :post, class: 'ui button red',
              data: { confirm: t('phrases.confirm') }
    end

    def send_confirmation_reminders_emails_link(event)
      return unless event.confirmation?

      link_to t('events.send_confirmation_reminders'),
              send_confirmation_reminders_admin_event_visit_requests_path(event),
              method: :post, class: 'ui button blue',
              data: { confirm: t('phrases.confirm') }
    end
  end
end
