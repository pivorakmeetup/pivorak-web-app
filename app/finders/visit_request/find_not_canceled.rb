class VisitRequest
 class FindNotCanceled < ApplicationFinder
    attr_reader :event, :user

    def initialize(user, event)
      @user  = user
      @event = event
    end

    def call
      return unless user && event

      VisitRequest.where.not(status: VisitRequest::CANCELED).find_by(user_id: user.id, event_id: event.id)
    end
  end
end
