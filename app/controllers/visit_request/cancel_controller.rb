class VisitRequest
  class CancelController < BaseController
    include ::VisitRequest::Concerns::VisitRequestFinder

    before_action :authenticate_user!

    def update
      ::VisitRequest::Cancel.call(visit_request)
      redirect_to event_path(event)
    end
  end
end
