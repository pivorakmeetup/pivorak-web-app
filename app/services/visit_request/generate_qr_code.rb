class VisitRequest
  class GenerateQrCode < ApplicationService
    include Rails.application.routes.url_helpers

    def initialize(visit_request)
      @visit_request = visit_request
    end

    def call
      tempfile = Tempfile.new
      pdf_document.render_file(tempfile)
      tempfile.rewind
      tempfile.read
    end

    private

    attr_reader :visit_request

    def qr_code
      check_in_visit_request_url = admin_visit_request_check_in_url(token: visit_request.token, host: host)
      # docs - https://github.com/jabbrwcky/prawn-qrcode
      RQRCode::QRCode.new(check_in_visit_request_url, level: :h, size: 30)
    end

    def pdf_document
      document = Prawn::Document::new
      document.render_qr_code(qr_code)
      document
    end

    def host
      Rails.application.config.action_mailer[:default_url_options][:host]
    end
  end
end
