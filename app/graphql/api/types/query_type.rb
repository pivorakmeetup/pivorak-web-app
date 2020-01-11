# frozen_string_literal: true

module Api
  module Types
    class QueryType < Types::BaseType
      field :me,     resolver: Queries::Me
      field :events, resolver: Queries::Events
      field :talks,  resolver: Queries::Talks
    end
  end
end
