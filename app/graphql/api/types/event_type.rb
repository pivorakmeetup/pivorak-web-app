# frozen_string_literal: true

module Api
  module Types
    class EventType < BaseType
      description 'Pivorak event info'

      field :id,           ID,                              'Event ID',                 null: false
      field :status,       String,                          'Event status',             null: false
      field :title,        String,                          'Title of the event',       null: false
      field :description,  String,                          'Description of the event', null: true
      field :agenda,       String,                          'Agenda of the event',      null: true
      field :startedAt,    GraphQL::Types::ISO8601DateTime, 'When event starts at',     null: false
      field :finishedAt,   GraphQL::Types::ISO8601DateTime, 'When event finished at',   null: false

      field :talks, [Types::TalkType], 'Event related talks', null: true do
        argument :pagination, InputObjects::Pagination, required: false
      end

      def talks(pagination: {})
        object.talks.offset(pagination[:offset]).limit(pagination[:limit])
      end
    end
  end
end
