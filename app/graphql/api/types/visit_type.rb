# frozen_string_literal: true

module Api
  module Types
    class VisitType < BaseType
      field :id, ID, null: false
      field :event, Types::EventType, null: false
      field :status, String, null: false
    end
  end
end
