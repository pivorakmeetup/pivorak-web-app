module Admin
  module EmailsHelper
    def send_email_to_recipient_ids_link(ids)
      link_to t('visit_requests.send_email_to_visitors'),
        new_admin_email_path(recipient_ids: ids),
        class: 'ui red button'
    end
  end
end
