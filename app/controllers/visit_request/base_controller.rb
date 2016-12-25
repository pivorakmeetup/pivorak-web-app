class VisitRequest
  class BaseController < ApplicationController
    private

    def event
      @event ||= Event.friendly.find(params[:event_id])
    end

    def visit_request
      @visit_request ||= Find.call(params)
    end
  end
end
