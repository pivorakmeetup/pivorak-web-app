class VisitRequest
  class VisitRequestsController < BaseController
    before_action :authenticate_user!

    def create
      VisitRequest::Create.call(current_user, event)
      redirect_to event_path(event)
    end
  end
end
