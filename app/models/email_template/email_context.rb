class EmailTemplate < ApplicationRecord
  class EmailContext < ActionView::Base
    include Rails.application.routes.url_helpers

    def host
      Rails.application.config.action_mailer[:default_url_options][:host]
    end

    def confirmation_url
      user_confirmation_url(confirmation_token: @token, host: host)
    end

    def change_password_url
      edit_user_password_url(reset_password_token: @token, host: host)
    end

    def _event_url
      event_url(@event, host: host)
    end

    def admin_visit_requests_url
      admin_event_visit_requests_url(@event, host: host)
    end

    def initialize(args = {})
      args.each do |k, v|
        instance_variable_set("@#{k}", v) unless v.nil?
      end
    end
  end
end
