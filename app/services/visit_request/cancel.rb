class VisitRequest
  class Cancel < ApplicationService
    def initialize(visit_request)
      @visit_request = visit_request
    end

    def call
      visit_request.canceled!
    end

    private

    attr_reader :visit_request
  end
end
