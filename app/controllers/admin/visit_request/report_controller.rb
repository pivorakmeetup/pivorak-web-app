module Admin
  class VisitRequest
    class ReportController < VisitRequest::BaseController
      delegate :verified_visitors, to: :event

      def download
        send_file ::PdfReports::EventVisitorsReport.call(verified_visitors.sorted)
      end
    end
  end
end
