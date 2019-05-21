# frozen_string_literal: true

module Admin
  module EmailsHelper
    def send_email_to_recipient_ids_link(ids)
      link_to t('visit_requests.send_email_to_visitors'),
              new_admin_email_path(recipient_ids: ids),
              class: 'ui green button'
    end

    def invite_user_link(event)
      link_to t('visit_requests.invite_user'), new_admin_event_invite_path(event), class: 'ui button blue'
    end
  end
end
