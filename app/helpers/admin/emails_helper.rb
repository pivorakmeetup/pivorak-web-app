module Admin
  module EmailsHelper
    def send_email_to_recipient_ids_link(ids)
      link_to t('visit_requests.send_email_to_visitors'),
        new_admin_email_path(recipient_ids: ids),
        class: 'mini ui red button'
    end

    def send_email_to_attendees_link(ids)
      link_to t('visit_requests.send_email_to_attendees'),
              new_admin_email_path(recipient_ids: ids),
              class: 'mini ui green button'
    end
  end
end
