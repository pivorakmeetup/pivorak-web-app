class VisitRequest
  class ToggleList < ApplicationService
    def initialize(visit_request)
      @visit_request = visit_request
    end

    def call
      if visit_request.waiting_list?
        visit_request.main_list!
      else
        visit_request.waiting_list!
      end
    end

    private

    attr_reader :visit_request
  end
end
