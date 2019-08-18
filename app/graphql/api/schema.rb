# frozen_string_literal: true

module Api
  class Schema < GraphQL::Schema
    mutation(Types::MutationType)
    query(Types::QueryType)
  end
end
