# frozen_string_literal: true

class VisitRequest
  module QrCode
    class Generate < ApplicationService
      def initialize(visit_request)
        @visit_request = visit_request
      end

      def call
        RQRCode::QRCode.new(check_in_url, level: :h)
      end

      private

      attr_reader :visit_request

      def check_in_url
        VisitRequest::QrCode::Url.call(visit_request)
      end
    end
  end
end
