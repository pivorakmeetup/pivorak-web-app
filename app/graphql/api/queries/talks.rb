# frozen_string_literal: true

module Api
  module Queries
    class Talks < BaseQuery
      type [Types::TalkType], null: false

      argument :pagination, InputObjects::Pagination, required: false
      argument :search, InputObjects::Search, required: false
      argument :filter, InputObjects::Filter, required: false

      description "Get list of all visible pivorak's talks info"

      def resolve(pagination: {}, search: {}, filter: {})
        scope = if search.present?
                  Search::Resource.call({ query: search['title'] }.merge(model: Talk))
                else
                  Talk.all
                end

        scope = scope.tagged_with(filter[:tags]) if filter[:tags]
        scope = scope.sorted.offset(pagination[:offset]).limit(pagination[:limit]) if pagination.present?
        scope
      end
    end
  end
end
