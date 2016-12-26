class VisitRequest
  class Attend < ApplicationService

    def initialize(user, event)
      @user = user
      @event = event
    end

    def call
      visit_request = VisitRequest.find_or_initialize_by(user: user, event: event)
      visit_request.pending!
    end

    private

    attr_reader :user, :event
  end
end
