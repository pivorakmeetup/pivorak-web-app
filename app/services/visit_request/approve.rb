class VisitRequest
  class Approve < ApplicationService
    def initialize(visit_request)
      @visit_request = visit_request
    end

    def call
      visit_request.approved!
      VisitRequestMailer.approved(visit_request).deliver_later
    end

    private

    attr_reader :visit_request
  end
end
