class VisitRequest
  class Create < ApplicationService

    def initialize(user, event)
      @user = user
      @event = event
    end

    def call
      VisitRequest.create!(user: user, event: event, status: PENDING)
    end

    private

    attr_reader :user, :event
  end
end
