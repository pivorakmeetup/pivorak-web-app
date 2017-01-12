class VisitRequest
  class ToggleVisit < ApplicationService
    def initialize(visit_request)
      @visit_request = visit_request
    end

    def call
      visit_request.update(visited: !visit_request.visited?)
    end

    private

    attr_reader :visit_request
  end
end
