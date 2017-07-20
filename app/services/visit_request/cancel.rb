class VisitRequest
  class Cancel < ApplicationService
    def initialize(visit_request)
      @visit_request = visit_request
    end

    def call
      visit_request.canceled!
      VisitRequestMailer.notify_admin_about_canceled_attendee(visit_request).deliver_later
    end

    private

    attr_reader :visit_request
  end
end
