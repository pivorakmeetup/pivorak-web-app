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
  end
end
