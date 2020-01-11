# frozen_string_literal: true

module Api
  module Types
    class MutationType < Types::BaseType
      field :create_visit_request, mutation: Api::Mutations::CreateVisitRequest
    end
  end
end
