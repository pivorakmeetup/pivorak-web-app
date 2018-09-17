class VisitRequest
  class CheckIn < ApplicationService
    AlreadyCheckedIn = Class.new(StandardError)
    InvalidStatus = Class.new(StandardError)

    def initialize(visit_request)
      @visit_request = visit_request
    end

    def call
      raise AlreadyCheckedIn if visit_request.visited?
      raise InvalidStatus unless visit_request.approved?

      visit_request.update(visited: true, checked_in_at: Time.zone.now)
    end

    private

    attr_reader :visit_request
  end
end
