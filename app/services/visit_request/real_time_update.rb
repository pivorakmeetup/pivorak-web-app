# frozen_string_literal: true

class VisitRequest
  class RealTimeUpdate < ApplicationService
    def initialize(visit_request)
      @visit_request = visit_request
    end

    def call
      ActionCable.server.broadcast(
        "visit_requests_#{event.id}_channel",
        partial:          render_visit_request(visit_request),
        visit_request_id: visit_request.id
      )
    end

    private

    attr_reader :visit_request

    delegate :event, to: :visit_request

    def render_visit_request(visit_request)
      ApplicationController.render(
        partial: 'admin/visit_requests/visit_request',
        locals:  {
          visit_request: visit_request,
          event:         event
        }
      )
    end
  end
end
