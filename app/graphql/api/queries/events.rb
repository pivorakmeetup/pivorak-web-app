# frozen_string_literal: true

module Api
  module Queries
    class Events < BaseQuery
      type [Types::EventType], null: false

      argument :pagination, InputObjects::Pagination, required: false

      description "Get list of all visible pivorak's events info"

      def resolve(pagination: {})
        Event.display.published.offset(pagination[:offset]).limit(pagination[:limit])
      end
    end
  end
end
