class VisitRequest
  class CheckIn < ApplicationService
    def initialize(visit_request)
      @visit_request = visit_request
    end

    def call
      status = if visit_request.nil?
          :not_found
        elsif visit_request.visited?
         :already_visited
        elsif  !visit_request.approved?
          :invalid_status
        else
         :success
      end

      visit_request.update(visited: true, checked_in_at: Time.current) if status == :success

      [visit_request, status]
    end

    private

    attr_reader :visit_request
  end
end
