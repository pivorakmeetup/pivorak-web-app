class VisitRequest
  class Refuse < ApplicationService
    def initialize(visit_request)
      @visit_request = visit_request
    end

    def call
      visit_request.refused!
    end

    private

    attr_reader :visit_request
  end
end
