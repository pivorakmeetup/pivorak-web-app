# frozen_string_literal: true

module Api
  module Types
    class EventType < BaseType
      field :id, ID, null: false
      field :title, String, null: false
    end
  end
end
