class VisitRequest
  class BaseController < ApplicationController
    private

    def event
      @event ||= Event.friendly.find(params[:event_id])
    end

    def visit_request
      @visit_request ||= ::VisitRequest.find(params[:visit_request_id])
    end
  end
end
