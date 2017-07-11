class VisitRequest
  class Cancel < ApplicationService
    def initialize(visit_request)
      @visit_request = visit_request
    end

    def call
      visit_request.canceled!
      attend_first_user_from_waitlist
    end

    private

    attr_reader :visit_request

    def attend_first_user_from_waitlist
      return unless waiting_list_request = VisitRequest.waiting_list.first

      waiting_list_request.main_list!

      if visit_request.event.registration?
        VisitRequest::Approve.call(waiting_list_request)
      else
        VisitRequest::FinalConfirmation(waiting_list_request)
      end
    end
  end
end
