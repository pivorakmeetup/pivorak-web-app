module Admin
  class VisitRequest
    class ReportController < VisitRequest::VisitRequestsController
      def download
        send_file ::PdfReports::EventVisitorsReport.call(visit_requests.final)
      end
    end
  end
end
