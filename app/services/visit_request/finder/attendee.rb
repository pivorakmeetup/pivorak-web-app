class VisitRequest
  module Finder
    class Attendee < ApplicationService
      attr_reader :event, :user

      def initialize(user, event)
        @user  = user
        @event = event
      end

      def call
        return false unless user
        return false unless event

        VisitRequest.find_by(user_id: user.id, event_id: event.id)
      end

      def self.call(*args)
        new(*args).call
      end
    end
  end
end
