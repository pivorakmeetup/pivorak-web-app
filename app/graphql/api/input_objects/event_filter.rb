# frozen_string_literal: true

module Api
  module InputObjects
    class EventFilter < BaseInputObject
      argument :status, [Enums::EventStatus], 'Filter events by sttaus', required: false
    end
  end
end
