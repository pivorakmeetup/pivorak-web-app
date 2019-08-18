# frozen_string_literal: true

module Api
  module Mutations
    class CreateVisitRequest < BaseMutation
      description 'Post a request for event attendance. Admin will review it as soon as possible.'

      type Types::VisitType

      argument :event_id, ID, 'Pass ID of event with registration status', required: true

      def resolve(event_id:)
        event = Event.find_by!(id: event_id, status: Event::REGISTRATION)

        VisitRequest::Create.call(context[:current_user], event)
      end
    end
  end
end
