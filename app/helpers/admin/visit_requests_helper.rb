module Admin
  module VisitRequestsHelper

    STATUS_CLASS = {
        ::VisitRequest::PENDING => 'bg-info',
        ::VisitRequest::APPROVED => 'bg-success',
        ::VisitRequest::CANCELED => 'bg-danger'
    }

    def status_cell(status)
      content_tag :td, class: STATUS_CLASS[status.to_sym] do
        status
      end
    end

  end
end
