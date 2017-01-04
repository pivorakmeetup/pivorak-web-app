class VisitRequest
  class AttendController < BaseController
    def update
      VisitRequest::Attend.call(current_user, event)
      redirect_to event_path(event)
    end
  end
end
