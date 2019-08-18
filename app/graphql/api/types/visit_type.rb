# frozen_string_literal: true

module Api
  module Types
    class VisitType < BaseType
      description 'Member event visit info'

      field :id,           ID,                 'Visit ID',                          null: false
      field :status,       Enums::VisitStatus, 'Visit status',                      null: false
      field :waiting_list, Boolean,            'Visit request is in waiting list',  null: false
      field :visited,      Boolean,            'Visit has been succeeded',          null: false
      field :event,        Types::EventType,   'Visit related event',               null: false

      field :checkedInAt,
            GraphQL::Types::ISO8601DateTime,
            'When member checked-in at event',
            null: true
    end
  end
end
