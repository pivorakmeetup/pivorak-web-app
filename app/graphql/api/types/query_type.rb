# frozen_string_literal: true

module Api
  module Types
    class QueryType < Types::BaseType
      field :me,     resolver: Queries::Me
      field :events, resolver: Queries::Events
    end
  end
end
