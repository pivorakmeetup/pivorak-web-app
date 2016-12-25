class VisitRequest
  class Approve < ApplicationService
    def initialize(visit_request)
      @visit_request = visit_request
    end

    def call
      visit_request.approved!
    end

    private

    attr_reader :visit_request
  end
end
