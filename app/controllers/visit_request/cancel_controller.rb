class VisitRequest
  class CancelController < BaseController
    before_action :authenticate_user!

    def update
      ::VisitRequest::Cancel.call(visit_request)
      redirect_to event_path(event)
    end
  end
end
