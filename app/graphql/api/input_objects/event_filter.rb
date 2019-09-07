# frozen_string_literal: true

module Api
  module InputObjects
    class EventFilter < BaseInputObject
      argument :status,    [Enums::EventStatus], 'Filter events by status', required: false
      argument :venue_ids, [Integer], 'Filter events by venue ids', required: false
    end
  end
end
