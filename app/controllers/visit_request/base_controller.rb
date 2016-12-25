class VisitRequest
  class BaseController < ApplicationController
    private

    def event
      @event ||= Event.friendly.find(params[:event_id])
    end

  end
end
