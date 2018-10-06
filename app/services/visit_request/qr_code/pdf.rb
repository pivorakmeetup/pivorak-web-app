class VisitRequest
  module QrCode
    class Pdf < ApplicationService
      def initialize(visit_request)
        @visit_request = visit_request
      end

      def call
        check_in_url = VisitRequest::QrCode::Url.call(visit_request)

        pdf_document = Prawn::Document.new(page_size: 'A4') do
          print_qr_code(check_in_url, extent: 200, stroke: false)
        end

        tempfile = Tempfile.new
        pdf_document.render_file(tempfile)
        tempfile.rewind
        tempfile.read
      end

      private

      attr_reader :visit_request
    end
  end
end
