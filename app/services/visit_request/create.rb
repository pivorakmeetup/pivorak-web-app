class VisitRequest
  class Create < ApplicationService

    def initialize(user, event)
      @user = user
      @event = event
    end

    def call
      visit_request = VisitRequest.new(user: user, event: event)
      visit_request.pending!
    end

    private

    attr_reader :user, :event
  end
end
