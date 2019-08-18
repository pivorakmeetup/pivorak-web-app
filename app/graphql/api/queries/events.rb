# frozen_string_literal: true

module Api
  module Queries
    class Events < BaseQuery
      type [Types::EventType], null: false

      description "Get list of all visible pivorak's events info"

      def resolve
        Event.display.published
      end
    end
  end
end
