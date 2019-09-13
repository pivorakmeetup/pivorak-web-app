# frozen_string_literal: true

module Api
  module InputObjects
    class EventRange < BaseInputObject
      argument :from,  GraphQL::Types::ISO8601DateTime, 'Events started after', required: false
      argument :to, GraphQL::Types::ISO8601DateTime, 'Events started before', required: false
    end
  end
end
