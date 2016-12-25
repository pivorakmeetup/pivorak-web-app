class VisitRequest
  class AttendController < BaseController
    before_action :authenticate_user!

    def update
      VisitRequest::Attend.call(current_user, event)
      redirect_to event_path(event)
    end
  end
end
