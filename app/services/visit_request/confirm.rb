class VisitRequest
  class Confirm < ApplicationService
    def initialize(visit_request)
      @visit_request = visit_request
    end

    def call
      visit_request.confirmed!
      VisitRequestMailer.attendance_confirmed(visit_request).deliver_later
    end

    private

    attr_reader :visit_request
  end
end
