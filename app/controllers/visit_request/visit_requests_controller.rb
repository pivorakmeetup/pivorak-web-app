class VisitRequest
  class VisitRequestsController < ApplicationController
    before_action :authenticate_user!

    def create
      VisitRequest::Create.call(current_user, event)
      redirect_to event_path(event)
    end

    private

    def event
      @event ||= Event.friendly.find(params[:event_id])
    end
  end
end
