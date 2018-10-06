class VisitRequest
  module QrCode
    class Url < ApplicationService
      def initialize(visit_request)
        @visit_request = visit_request
      end

      def call
        url_helpers.admin_visit_request_check_in_url(token: visit_request.token, host: host)
      end

      private
      attr_reader :visit_request

      def url_helpers
        Rails.application.routes.url_helpers
      end

      def host
        Rails.application.config.action_mailer[:default_url_options][:host]
      end
    end
  end
end
