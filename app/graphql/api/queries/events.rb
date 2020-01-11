# frozen_string_literal: true

module Api
  module Queries
    class Events < BaseQuery
      type [Types::EventType], null: false

      argument :pagination, InputObjects::Pagination,  required: false
      argument :filter,     InputObjects::EventFilter, required: false

      description "Get list of all visible pivorak's events info"

      # rubocop:disable Metrics/AbcSize
      def resolve(pagination: {}, filter: {})
        events = Event.visible.published

        events = events.where(status:   filter[:status])   if filter[:status]
        events = events.where(venue_id: filter[:venueIds]) if filter[:venueIds]

        if filter[:start_at].present?
          start_from = filter.dig(:start_at, :from) || 10.years.ago
          end_at = filter.dig(:start_at, :to) || Time.current

          events = events.where(started_at: start_from.utc..end_at.utc)
        end

        events.offset(pagination[:offset]).limit(pagination[:limit]).order(started_at: :desc)
      end
      # rubocop:enable Metrics/AbcSize
    end
  end
end
